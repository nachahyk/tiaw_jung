import 'package:tiaw_jung/src/features/itinerary/data/datasources/itinerary_remote_data_source.dart';
import 'package:tiaw_jung/src/features/itinerary/domain/entities/itinerary_stop.dart';
import 'package:tiaw_jung/src/features/itinerary/domain/repositories/itinerary_repository.dart';

class ItineraryRepositoryImpl implements ItineraryRepository {
  ItineraryRepositoryImpl(this._remoteDataSource);

  final ItineraryRemoteDataSource _remoteDataSource;

  @override
  Future<List<ItineraryStop>> fetchStops(String tripId) => _remoteDataSource.fetchStops(tripId);

  @override
  Future<ItineraryStop> createStop(ItineraryStop stop) => _remoteDataSource.createStop(stop);

  @override
  Future<ItineraryStop> updateStop(ItineraryStop stop) => _remoteDataSource.updateStop(stop);

  @override
  Future<void> deleteStop(String stopId) => _remoteDataSource.deleteStop(stopId);

  @override
  Future<void> reorderStops(List<String> stopIds) => _remoteDataSource.reorderStops(stopIds);
}
