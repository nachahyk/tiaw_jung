import 'package:equatable/equatable.dart';

import 'package:tiaw_jung/src/features/itinerary/domain/entities/itinerary_stop.dart';

enum ItineraryStatus { initial, loading, loaded, error }

enum ItineraryActionStatus { idle, saving, success, failure }

class ItineraryState extends Equatable {
  const ItineraryState({
    this.status = ItineraryStatus.initial,
    this.stops = const [],
    this.error,
    this.actionStatus = ItineraryActionStatus.idle,
    this.actionError,
  });

  final ItineraryStatus status;
  final List<ItineraryStop> stops;
  final String? error;
  final ItineraryActionStatus actionStatus;
  final String? actionError;

  /// Stops grouped by calendar day, in day order — what the trip detail
  /// page actually renders (a section per day).
  Map<DateTime, List<ItineraryStop>> get stopsByDay {
    final grouped = <DateTime, List<ItineraryStop>>{};
    for (final stop in stops) {
      final day = DateTime(stop.dayDate.year, stop.dayDate.month, stop.dayDate.day);
      (grouped[day] ??= []).add(stop);
    }
    return Map.fromEntries(grouped.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));
  }

  ItineraryState copyWith({
    ItineraryStatus? status,
    List<ItineraryStop>? stops,
    String? error,
    bool clearError = false,
    ItineraryActionStatus? actionStatus,
    String? actionError,
    bool clearActionError = false,
  }) {
    return ItineraryState(
      status: status ?? this.status,
      stops: stops ?? this.stops,
      error: clearError ? null : (error ?? this.error),
      actionStatus: actionStatus ?? this.actionStatus,
      actionError: clearActionError ? null : (actionError ?? this.actionError),
    );
  }

  @override
  List<Object?> get props => [status, stops, error, actionStatus, actionError];
}
