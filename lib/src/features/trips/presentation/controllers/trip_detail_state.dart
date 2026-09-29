import 'package:equatable/equatable.dart';

import 'package:tiaw_jung/src/features/trips/domain/entities/trip.dart';
import 'package:tiaw_jung/src/features/trips/domain/entities/trip_member.dart';

enum TripDetailStatus { initial, loading, loaded, error }

enum TripDetailActionStatus { idle, saving, success, failure, left }

class TripDetailState extends Equatable {
  const TripDetailState({
    this.status = TripDetailStatus.initial,
    this.trip,
    this.members = const [],
    this.error,
    this.actionStatus = TripDetailActionStatus.idle,
    this.actionError,
  });

  final TripDetailStatus status;
  final Trip? trip;
  final List<TripMember> members;
  final String? error;
  final TripDetailActionStatus actionStatus;
  final String? actionError;

  TripDetailState copyWith({
    TripDetailStatus? status,
    Trip? trip,
    List<TripMember>? members,
    String? error,
    bool clearError = false,
    TripDetailActionStatus? actionStatus,
    String? actionError,
    bool clearActionError = false,
  }) {
    return TripDetailState(
      status: status ?? this.status,
      trip: trip ?? this.trip,
      members: members ?? this.members,
      error: clearError ? null : (error ?? this.error),
      actionStatus: actionStatus ?? this.actionStatus,
      actionError: clearActionError ? null : (actionError ?? this.actionError),
    );
  }

  @override
  List<Object?> get props => [status, trip, members, error, actionStatus, actionError];
}
