import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tiaw_jung/src/features/itinerary/domain/entities/itinerary_stop.dart';
import 'package:tiaw_jung/src/features/itinerary/domain/repositories/itinerary_repository.dart';
import 'package:tiaw_jung/src/features/itinerary/presentation/controllers/itinerary_state.dart';

/// Drives one trip's itinerary — a fresh instance per trip, same as
/// `TripDetailCubit`.
class ItineraryCubit extends Cubit<ItineraryState> {
  ItineraryCubit(this._repository) : super(const ItineraryState());

  final ItineraryRepository _repository;

  Future<void> loadStops(String tripId) async {
    emit(state.copyWith(status: ItineraryStatus.loading, clearError: true));
    try {
      final stops = await _repository.fetchStops(tripId);
      emit(state.copyWith(status: ItineraryStatus.loaded, stops: stops));
    } catch (error) {
      emit(state.copyWith(status: ItineraryStatus.error, error: error.toString()));
    }
  }

  Future<void> addStop(ItineraryStop stop) async {
    emit(state.copyWith(actionStatus: ItineraryActionStatus.saving, clearActionError: true));
    try {
      final created = await _repository.createStop(stop);
      emit(state.copyWith(actionStatus: ItineraryActionStatus.success, stops: [...state.stops, created]));
    } catch (error) {
      emit(state.copyWith(actionStatus: ItineraryActionStatus.failure, actionError: error.toString()));
    }
  }

  Future<void> updateStop(ItineraryStop stop) async {
    emit(state.copyWith(actionStatus: ItineraryActionStatus.saving, clearActionError: true));
    try {
      final updated = await _repository.updateStop(stop);
      emit(state.copyWith(
        actionStatus: ItineraryActionStatus.success,
        stops: [for (final s in state.stops) if (s.id == updated.id) updated else s],
      ));
    } catch (error) {
      emit(state.copyWith(actionStatus: ItineraryActionStatus.failure, actionError: error.toString()));
    }
  }

  Future<void> deleteStop(String stopId) async {
    emit(state.copyWith(actionStatus: ItineraryActionStatus.saving, clearActionError: true));
    try {
      await _repository.deleteStop(stopId);
      emit(state.copyWith(
        actionStatus: ItineraryActionStatus.success,
        stops: [for (final s in state.stops) if (s.id != stopId) s],
      ));
    } catch (error) {
      emit(state.copyWith(actionStatus: ItineraryActionStatus.failure, actionError: error.toString()));
    }
  }

  void resetActionStatus() => emit(state.copyWith(actionStatus: ItineraryActionStatus.idle));
}
