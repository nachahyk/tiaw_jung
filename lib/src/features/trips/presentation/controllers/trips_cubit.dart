import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tiaw_jung/src/features/trips/domain/repositories/trip_repository.dart';
import 'package:tiaw_jung/src/features/trips/presentation/controllers/trips_state.dart';

class TripsCubit extends Cubit<TripsState> {
  TripsCubit(this._repository) : super(const TripsState());

  final TripRepository _repository;

  Future<void> loadTrips() async {
    emit(state.copyWith(status: TripsStatus.loading, clearError: true));
    try {
      final trips = await _repository.fetchMyTrips();
      emit(state.copyWith(status: TripsStatus.loaded, trips: trips));
    } catch (error) {
      emit(state.copyWith(status: TripsStatus.error, error: error.toString()));
    }
  }

  Future<void> createTrip({
    required String name,
    String? destination,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    emit(state.copyWith(actionStatus: TripsActionStatus.saving, clearActionError: true));
    try {
      final trip = await _repository.createTrip(
        name: name,
        destination: destination,
        startDate: startDate,
        endDate: endDate,
      );
      emit(state.copyWith(
        actionStatus: TripsActionStatus.success,
        createdTrip: trip,
        trips: [trip, ...state.trips],
      ));
    } catch (error) {
      emit(state.copyWith(actionStatus: TripsActionStatus.failure, actionError: error.toString()));
    }
  }

  Future<void> joinTrip(String code) async {
    emit(state.copyWith(actionStatus: TripsActionStatus.saving, clearActionError: true));
    try {
      final trip = await _repository.joinTripByCode(code);
      emit(state.copyWith(
        actionStatus: TripsActionStatus.success,
        createdTrip: trip,
        trips: [trip, ...state.trips],
      ));
    } catch (error) {
      emit(state.copyWith(actionStatus: TripsActionStatus.failure, actionError: error.toString()));
    }
  }

  void resetActionStatus() => emit(state.copyWith(actionStatus: TripsActionStatus.idle, clearCreatedTrip: true));
}
