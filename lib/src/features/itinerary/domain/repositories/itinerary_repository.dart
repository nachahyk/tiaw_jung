import 'package:tiaw_jung/src/features/itinerary/domain/entities/itinerary_stop.dart';

abstract class ItineraryRepository {
  Future<List<ItineraryStop>> fetchStops(String tripId);

  Future<ItineraryStop> createStop(ItineraryStop stop);

  Future<ItineraryStop> updateStop(ItineraryStop stop);

  Future<void> deleteStop(String stopId);

  /// Persists a new relative order for [stopIds] (all belonging to the same
  /// day) after a drag-reorder.
  Future<void> reorderStops(List<String> stopIds);
}
