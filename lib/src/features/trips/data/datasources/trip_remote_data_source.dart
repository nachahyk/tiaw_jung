import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:tiaw_jung/src/features/trips/domain/entities/trip.dart';
import 'package:tiaw_jung/src/features/trips/domain/entities/trip_member.dart';

Trip _tripFromMap(Map<String, dynamic> map, String currentUserId) {
  final members = (map['trip_members'] as List<dynamic>?) ?? const [];
  final isOrganizer = members.any(
    (row) => (row as Map<String, dynamic>)['user_id'] == currentUserId && row['role'] == 'organizer',
  );
  return Trip(
    id: map['id'] as String,
    name: map['name'] as String,
    destination: map['destination'] as String?,
    startDate: map['start_date'] == null ? null : DateTime.parse(map['start_date'] as String),
    endDate: map['end_date'] == null ? null : DateTime.parse(map['end_date'] as String),
    joinCode: map['join_code'] as String,
    isOrganizer: isOrganizer,
  );
}

/// Talks to `trips`/`trip_members` directly for plain reads/writes, and to
/// the `create_trip`/`join_trip_by_code` RPCs for the two flows that need
/// to touch both tables atomically (mirrors how AimJung's restaurants
/// feature uses `create_restaurant`).
class TripRemoteDataSource {
  TripRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const _selectWithMembership = '*, trip_members(user_id, role)';

  String get _userId => _client.auth.currentUser!.id;

  Future<List<Trip>> fetchMyTrips() async {
    final rows = await _client
        .from('trips')
        .select(_selectWithMembership)
        .order('created_at', ascending: false);
    return rows.map((row) => _tripFromMap(row, _userId)).toList();
  }

  Future<Trip> fetchTrip(String tripId) async {
    final row = await _client.from('trips').select(_selectWithMembership).eq('id', tripId).single();
    return _tripFromMap(row, _userId);
  }

  Future<Trip> createTrip({
    required String name,
    String? destination,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final tripId = await _client.rpc('create_trip', params: {
      'p_name': name,
      'p_destination': destination,
      'p_start_date': startDate?.toIso8601String().split('T').first,
      'p_end_date': endDate?.toIso8601String().split('T').first,
    }) as String;
    return fetchTrip(tripId);
  }

  Future<Trip> joinTripByCode(String code) async {
    final tripId = await _client.rpc('join_trip_by_code', params: {'p_code': code}) as String;
    return fetchTrip(tripId);
  }

  Future<List<TripMember>> fetchMembers(String tripId) async {
    final rows = await _client
        .from('trip_members')
        .select('user_id, role, profiles(full_name, email)')
        .eq('trip_id', tripId);
    return rows.map((row) {
      final profile = row['profiles'] as Map<String, dynamic>?;
      return TripMember(
        userId: row['user_id'] as String,
        role: row['role'] == 'organizer' ? TripRole.organizer : TripRole.member,
        fullName: profile?['full_name'] as String?,
        email: profile?['email'] as String?,
      );
    }).toList();
  }

  Future<void> leaveTrip(String tripId) {
    return _client.from('trip_members').delete().eq('trip_id', tripId).eq('user_id', _userId);
  }
}
