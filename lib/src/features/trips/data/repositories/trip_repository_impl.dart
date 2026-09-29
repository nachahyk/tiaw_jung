import 'package:tiaw_jung/src/features/trips/data/datasources/trip_remote_data_source.dart';
import 'package:tiaw_jung/src/features/trips/domain/entities/trip.dart';
import 'package:tiaw_jung/src/features/trips/domain/entities/trip_member.dart';
import 'package:tiaw_jung/src/features/trips/domain/repositories/trip_repository.dart';

class TripRepositoryImpl implements TripRepository {
  TripRepositoryImpl(this._remoteDataSource);

  final TripRemoteDataSource _remoteDataSource;

  @override
  Future<List<Trip>> fetchMyTrips() => _remoteDataSource.fetchMyTrips();

  @override
  Future<Trip> fetchTrip(String tripId) => _remoteDataSource.fetchTrip(tripId);

  @override
  Future<Trip> createTrip({
    required String name,
    String? destination,
    DateTime? startDate,
    DateTime? endDate,
  }) =>
      _remoteDataSource.createTrip(name: name, destination: destination, startDate: startDate, endDate: endDate);

  @override
  Future<Trip> joinTripByCode(String code) => _remoteDataSource.joinTripByCode(code);

  @override
  Future<List<TripMember>> fetchMembers(String tripId) => _remoteDataSource.fetchMembers(tripId);

  @override
  Future<void> leaveTrip(String tripId) => _remoteDataSource.leaveTrip(tripId);
}
