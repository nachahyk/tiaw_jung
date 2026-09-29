import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:tiaw_jung/src/theme/app_colors.dart';
import 'package:tiaw_jung/l10n/app_localizations.dart';
import 'package:tiaw_jung/src/core/widgets/tj_page_header.dart';
import 'package:tiaw_jung/src/routes/app_routes.dart';
import 'package:tiaw_jung/src/features/itinerary/domain/entities/itinerary_stop.dart';
import 'package:tiaw_jung/src/features/itinerary/presentation/controllers/itinerary_cubit.dart';
import 'package:tiaw_jung/src/features/itinerary/presentation/controllers/itinerary_state.dart';
import 'package:tiaw_jung/src/features/trips/presentation/controllers/trip_detail_cubit.dart';
import 'package:tiaw_jung/src/features/trips/presentation/controllers/trip_detail_state.dart';

/// A trip's itinerary — one section per day, grouped from `ItineraryCubit`'s
/// stops. `TripDetailCubit` (the trip + its members) and `ItineraryCubit`
/// are both scoped to this one trip, provided fresh per navigation by
/// `TiawJungModule`'s route builder.
class TripDetailPage extends StatefulWidget {
  const TripDetailPage({super.key, required this.tripId});

  final String tripId;

  @override
  State<TripDetailPage> createState() => _TripDetailPageState();
}

class _TripDetailPageState extends State<TripDetailPage> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);
    final tripState = context.watch<TripDetailCubit>().state;
    final itineraryState = context.watch<ItineraryCubit>().state;
    final trip = tripState.trip;

    return Scaffold(
      appBar: TjPageHeader(
        title: trip?.name ?? '',
        actions: [
          IconButton(
            icon: const Icon(Icons.group_outlined),
            onPressed: trip == null ? null : () => _showMembers(context, tripState),
          ),
        ],
      ),
      body: itineraryState.status == ItineraryStatus.loading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
                children: [
                  if (trip != null)
                    Text(l10n.tripDetailJoinCode(trip.joinCode), style: TextStyle(fontSize: 12.5, color: colors.textMuted)),
                  const SizedBox(height: 16),
                  if (itineraryState.stopsByDay.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Center(
                        child: Text(l10n.tripDetailEmptyDay, style: TextStyle(color: colors.textMuted)),
                      ),
                    )
                  else
                    for (final entry in itineraryState.stopsByDay.entries.toList().asMap().entries)
                      _DaySection(
                        dayNumber: entry.key + 1,
                        date: entry.value.key,
                        stops: entry.value.value,
                        tripId: widget.tripId,
                      ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.stopNew(widget.tripId)),
        icon: const Icon(Icons.add_location_alt_outlined),
        label: Text(l10n.tripDetailAddStopButton),
        shape: const StadiumBorder(),
      ),
    );
  }

  void _showMembers(BuildContext context, TripDetailState state) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.tripMembersTitle, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: colors.textPrimary)),
                const SizedBox(height: 12),
                for (final member in state.members)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: colors.primaryTint,
                      child: Text(
                        (member.fullName ?? member.email ?? '?').substring(0, 1).toUpperCase(),
                        style: TextStyle(color: colors.primary, fontWeight: FontWeight.w700),
                      ),
                    ),
                    title: Text(member.fullName ?? member.email ?? ''),
                    trailing: member.role.name == 'organizer'
                        ? Icon(Icons.star, size: 16, color: colors.mustard)
                        : null,
                  ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () => _confirmLeave(sheetContext),
                  child: Text(l10n.tripLeaveButton),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _confirmLeave(BuildContext sheetContext) async {
    final l10n = AppLocalizations.of(sheetContext)!;
    final confirmed = await showDialog<bool>(
      context: sheetContext,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.tripLeaveConfirmTitle),
        content: Text(l10n.tripLeaveConfirmBody),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: Text(l10n.commonCancel)),
          FilledButton(onPressed: () => Navigator.of(dialogContext).pop(true), child: Text(l10n.tripLeaveButton)),
        ],
      ),
    );
    if (confirmed != true || !sheetContext.mounted) return;
    await sheetContext.read<TripDetailCubit>().leaveTrip();
    if (!sheetContext.mounted) return;
    Navigator.of(sheetContext).pop();
    sheetContext.go(AppRoutes.trips);
  }
}

class _DaySection extends StatelessWidget {
  const _DaySection({required this.dayNumber, required this.date, required this.stops, required this.tripId});

  final int dayNumber;
  final DateTime date;
  final List<ItineraryStop> stops;
  final String tripId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.tripDetailDayLabel(dayNumber, '${date.day}/${date.month}'),
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: colors.primaryDark),
          ),
          const SizedBox(height: 10),
          Material(
            color: colors.card,
            borderRadius: BorderRadius.circular(16),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                for (var i = 0; i < stops.length; i++) ...[
                  if (i > 0) Divider(height: 1, color: colors.border),
                  _StopRow(stop: stops[i], tripId: tripId),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StopRow extends StatelessWidget {
  const _StopRow({required this.stop, required this.tripId});

  final ItineraryStop stop;
  final String tripId;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final time = stop.startTime;

    return ListTile(
      onTap: () => context.push(AppRoutes.stopEdit(tripId, stop.id)),
      leading: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(color: colors.primaryTint, borderRadius: BorderRadius.circular(10)),
        child: Icon(Icons.place_outlined, color: colors.primary, size: 17),
      ),
      title: Text(stop.title, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: colors.textPrimary)),
      subtitle: Text(
        [if (time != null) time.format(context), if (stop.address != null) stop.address!].join(' · '),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 11.5, color: colors.textMuted),
      ),
      trailing: Icon(Icons.chevron_right, color: colors.inactive),
    );
  }
}
