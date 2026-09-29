import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as ll;
import 'package:core_infra/core_infra.dart';

import 'package:tiaw_jung/src/theme/app_colors.dart';
import 'package:tiaw_jung/l10n/app_localizations.dart';
import 'package:tiaw_jung/src/core/widgets/tj_page_header.dart';

/// Default map center (Bangkok) used when there's no saved location and the
/// device's current location isn't available/granted.
const _defaultCenter = ll.LatLng(13.7563, 100.5018);

/// Full-screen OpenStreetMap picker for an itinerary stop — tap the map (or
/// search, or use the device's current location) to place a pin, then
/// confirm to pop a [PickedLocation] back to the caller. Same shape as
/// AimJung's location picker, built on the same shared `jung_studio_core`
/// geocoding data source, but themed for Tiaw Jung.
class TjLocationPickerPage extends StatefulWidget {
  const TjLocationPickerPage({super.key, this.initialLatitude, this.initialLongitude});

  final double? initialLatitude;
  final double? initialLongitude;

  @override
  State<TjLocationPickerPage> createState() => _TjLocationPickerPageState();
}

class _TjLocationPickerPageState extends State<TjLocationPickerPage> {
  final _geocoder = NominatimGeocodingDataSource(userAgent: 'TiawJungApp/1.0');
  final _mapController = MapController();
  final _searchController = TextEditingController();

  ll.LatLng? _selected;
  String? _address;
  bool _isResolvingAddress = false;
  bool _isSearching = false;
  bool _isLocating = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialLatitude != null && widget.initialLongitude != null) {
      _selected = ll.LatLng(widget.initialLatitude!, widget.initialLongitude!);
      _resolveAddress(_selected!);
    } else {
      _useCurrentLocation(fallbackToDefault: true);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _resolveAddress(ll.LatLng point) async {
    setState(() => _isResolvingAddress = true);
    try {
      final address = await _geocoder.reverseGeocode(point.latitude, point.longitude);
      if (!mounted) return;
      setState(() => _address = address ?? '${point.latitude}, ${point.longitude}');
    } catch (_) {
      if (!mounted) return;
      setState(() => _address = '${point.latitude}, ${point.longitude}');
    } finally {
      if (mounted) setState(() => _isResolvingAddress = false);
    }
  }

  void _selectPoint(ll.LatLng point) {
    setState(() => _selected = point);
    _mapController.move(point, _mapController.camera.zoom);
    _resolveAddress(point);
  }

  void _notify(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _useCurrentLocation({bool fallbackToDefault = false}) async {
    setState(() => _isLocating = true);
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled ||
          permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (fallbackToDefault) _selectPoint(_defaultCenter);
        if (mounted && !fallbackToDefault) {
          final l10n = AppLocalizations.of(context)!;
          _notify(l10n.locationPermissionDenied);
        }
        return;
      }

      final position = await Geolocator.getCurrentPosition();
      _selectPoint(ll.LatLng(position.latitude, position.longitude));
    } catch (_) {
      if (fallbackToDefault) _selectPoint(_defaultCenter);
    } finally {
      if (mounted) setState(() => _isLocating = false);
    }
  }

  Future<void> _search() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() => _isSearching = true);
    try {
      final results = await _geocoder.search(query);
      if (!mounted) return;
      if (results.isEmpty) {
        final l10n = AppLocalizations.of(context)!;
        _notify(l10n.locationSearchNoResults);
        return;
      }
      final first = results.first;
      setState(() => _address = first.address);
      _selectPoint(ll.LatLng(first.latitude, first.longitude));
    } catch (_) {
      // Swallow — the address bar simply won't update; the user can retry.
    } finally {
      if (mounted) setState(() => _isSearching = false);
    }
  }

  void _confirm() {
    final point = _selected;
    final address = _address;
    if (point == null || address == null) return;
    Navigator.of(context).pop(PickedLocation(address: address, latitude: point.latitude, longitude: point.longitude));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);
    final center = _selected ?? _defaultCenter;

    return Scaffold(
      appBar: TjPageHeader(title: l10n.locationPickerTitle),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: center,
              initialZoom: 15,
              onTap: (tapPosition, point) => _selectPoint(point),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.jungstudio.tiawjung',
              ),
              if (_selected != null)
                MarkerLayer(markers: [
                  Marker(
                    point: _selected!,
                    width: 40,
                    height: 40,
                    child: Icon(Icons.location_pin, size: 40, color: colors.primary),
                  ),
                ]),
            ],
          ),
          Positioned(
            top: 12,
            left: 16,
            right: 16,
            child: Material(
              color: colors.card,
              borderRadius: BorderRadius.circular(14),
              elevation: 3,
              shadowColor: colors.textPrimary.withValues(alpha: 0.35),
              child: TextField(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => _search(),
                decoration: InputDecoration(
                  hintText: l10n.locationSearchHint,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _isSearching
                      ? const Padding(
                          padding: EdgeInsets.all(12),
                          child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
                        )
                      : IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          color: colors.primary,
                          onPressed: _search,
                        ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                  filled: true,
                  fillColor: colors.card,
                ),
              ),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 140,
            child: FloatingActionButton(
              heroTag: 'tjUseCurrentLocation',
              onPressed: _isLocating ? null : () => _useCurrentLocation(),
              child: _isLocating
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
          decoration: BoxDecoration(
            color: colors.card,
            border: Border(top: BorderSide(color: colors.border)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _isResolvingAddress
                      ? l10n.locationResolvingAddress
                      : (_address ?? l10n.locationPickerTapToPlace),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, color: colors.textPrimary),
                ),
              ),
              const SizedBox(width: 12),
              FilledButton(
                onPressed: (_selected == null || _isResolvingAddress) ? null : _confirm,
                child: Text(l10n.locationConfirmButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
