import 'package:flutter/material.dart' show TimeOfDay;

/// One planned stop on a trip's itinerary, pinned to a specific [dayDate].
class ItineraryStop {
  const ItineraryStop({
    required this.id,
    required this.tripId,
    required this.dayDate,
    required this.title,
    this.address,
    this.latitude,
    this.longitude,
    this.startTime,
    this.note,
    required this.sortOrder,
  });

  final String id;
  final String tripId;
  final DateTime dayDate;
  final String title;
  final String? address;
  final double? latitude;
  final double? longitude;
  final TimeOfDay? startTime;
  final String? note;
  final int sortOrder;

  ItineraryStop copyWith({
    DateTime? dayDate,
    String? title,
    String? address,
    double? latitude,
    double? longitude,
    TimeOfDay? startTime,
    String? note,
    int? sortOrder,
  }) {
    return ItineraryStop(
      id: id,
      tripId: tripId,
      dayDate: dayDate ?? this.dayDate,
      title: title ?? this.title,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      startTime: startTime ?? this.startTime,
      note: note ?? this.note,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}
