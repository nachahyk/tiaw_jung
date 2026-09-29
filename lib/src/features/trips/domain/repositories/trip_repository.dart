import 'package:tiaw_jung/src/features/trips/domain/entities/trip.dart';
import 'package:tiaw_jung/src/features/trips/domain/entities/trip_member.dart';

abstract class TripRepository {
  /// Every trip the current user belongs to (organizer or member).
  Future<List<Trip>> fetchMyTrips();

  Future<Trip> fetchTrip(String tripId);

  Future<Trip> createTrip({
    required String name,
    String? destination,
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<Trip> joinTripByCode(String code);

  Future<List<TripMember>> fetchMembers(String tripId);

  Future<void> leaveTrip(String tripId);
}
