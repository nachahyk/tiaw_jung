import 'package:equatable/equatable.dart';

import 'package:tiaw_jung/src/features/trips/domain/entities/trip.dart';

enum TripsStatus { initial, loading, loaded, error }

enum TripsActionStatus { idle, saving, success, failure }

class TripsState extends Equatable {
  const TripsState({
    this.status = TripsStatus.initial,
    this.trips = const [],
    this.error,
    this.actionStatus = TripsActionStatus.idle,
    this.actionError,
    this.createdTrip,
  });

  final TripsStatus status;
  final List<Trip> trips;
  final String? error;
  final TripsActionStatus actionStatus;
  final String? actionError;

  /// The trip just created or joined — the page reads this once to
  /// navigate into it, then the cubit clears it back to null.
  final Trip? createdTrip;

  TripsState copyWith({
    TripsStatus? status,
    List<Trip>? trips,
    String? error,
    bool clearError = false,
    TripsActionStatus? actionStatus,
    String? actionError,
    bool clearActionError = false,
    Trip? createdTrip,
    bool clearCreatedTrip = false,
  }) {
    return TripsState(
      status: status ?? this.status,
      trips: trips ?? this.trips,
      error: clearError ? null : (error ?? this.error),
      actionStatus: actionStatus ?? this.actionStatus,
      actionError: clearActionError ? null : (actionError ?? this.actionError),
      createdTrip: clearCreatedTrip ? null : (createdTrip ?? this.createdTrip),
    );
  }

  @override
  List<Object?> get props => [status, trips, error, actionStatus, actionError, createdTrip];
}
