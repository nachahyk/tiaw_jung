import 'package:flutter/material.dart' show TimeOfDay;
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:tiaw_jung/src/features/itinerary/domain/entities/itinerary_stop.dart';

TimeOfDay? _parseTime(String? value) {
  if (value == null) return null;
  final parts = value.split(':');
  return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
}

String? _formatTime(TimeOfDay? time) {
  if (time == null) return null;
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute:00';
}

ItineraryStop _stopFromMap(Map<String, dynamic> map) {
  return ItineraryStop(
    id: map['id'] as String,
    tripId: map['trip_id'] as String,
    dayDate: DateTime.parse(map['day_date'] as String),
    title: map['title'] as String,
    address: map['address'] as String?,
    latitude: (map['lat'] as num?)?.toDouble(),
    longitude: (map['lng'] as num?)?.toDouble(),
    startTime: _parseTime(map['start_time'] as String?),
    note: map['note'] as String?,
    sortOrder: map['sort_order'] as int,
  );
}

class ItineraryRemoteDataSource {
  ItineraryRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<List<ItineraryStop>> fetchStops(String tripId) async {
    final rows = await _client
        .from('itinerary_stops')
        .select()
        .eq('trip_id', tripId)
        .order('day_date')
        .order('sort_order');
    return rows.map(_stopFromMap).toList();
  }

  Future<ItineraryStop> createStop(ItineraryStop stop) async {
    final row = await _client
        .from('itinerary_stops')
        .insert({
          'trip_id': stop.tripId,
          'day_date': stop.dayDate.toIso8601String().split('T').first,
          'title': stop.title,
          'address': stop.address,
          'lat': stop.latitude,
          'lng': stop.longitude,
          'start_time': _formatTime(stop.startTime),
          'note': stop.note,
          'sort_order': stop.sortOrder,
        })
        .select()
        .single();
    return _stopFromMap(row);
  }

  Future<ItineraryStop> updateStop(ItineraryStop stop) async {
    final row = await _client
        .from('itinerary_stops')
        .update({
          'day_date': stop.dayDate.toIso8601String().split('T').first,
          'title': stop.title,
          'address': stop.address,
          'lat': stop.latitude,
          'lng': stop.longitude,
          'start_time': _formatTime(stop.startTime),
          'note': stop.note,
          'sort_order': stop.sortOrder,
        })
        .eq('id', stop.id)
        .select()
        .single();
    return _stopFromMap(row);
  }

  Future<void> deleteStop(String stopId) {
    return _client.from('itinerary_stops').delete().eq('id', stopId);
  }

  Future<void> reorderStops(List<String> stopIds) async {
    for (var i = 0; i < stopIds.length; i++) {
      await _client.from('itinerary_stops').update({'sort_order': i}).eq('id', stopIds[i]);
    }
  }
}
