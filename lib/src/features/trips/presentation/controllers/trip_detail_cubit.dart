import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tiaw_jung/src/features/trips/domain/repositories/trip_repository.dart';
import 'package:tiaw_jung/src/features/trips/presentation/controllers/trip_detail_state.dart';

/// Drives one trip's detail page — the trip itself plus its member list.
/// A fresh instance is created per trip (not a singleton like `TripsCubit`),
/// so it's fine for its state to just be "whichever trip was last loaded."
class TripDetailCubit extends Cubit<TripDetailState> {
  TripDetailCubit(this._repository) : super(const TripDetailState());

  final TripRepository _repository;

  Future<void> loadTrip(String tripId) async {
    emit(state.copyWith(status: TripDetailStatus.loading, clearError: true));
    try {
      final trip = await _repository.fetchTrip(tripId);
      final members = await _repository.fetchMembers(tripId);
      emit(state.copyWith(status: TripDetailStatus.loaded, trip: trip, members: members));
    } catch (error) {
      emit(state.copyWith(status: TripDetailStatus.error, error: error.toString()));
    }
  }

  Future<void> leaveTrip() async {
    final trip = state.trip;
    if (trip == null) return;
    emit(state.copyWith(actionStatus: TripDetailActionStatus.saving, clearActionError: true));
    try {
      await _repository.leaveTrip(trip.id);
      emit(state.copyWith(actionStatus: TripDetailActionStatus.left));
    } catch (error) {
      emit(state.copyWith(actionStatus: TripDetailActionStatus.failure, actionError: error.toString()));
    }
  }

  void resetActionStatus() => emit(state.copyWith(actionStatus: TripDetailActionStatus.idle));
}
