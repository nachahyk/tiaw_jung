import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:tiaw_jung/src/theme/app_colors.dart';
import 'package:tiaw_jung/l10n/app_localizations.dart';
import 'package:tiaw_jung/src/routes/app_routes.dart';
import 'package:tiaw_jung/src/features/trips/domain/entities/trip.dart';
import 'package:tiaw_jung/src/features/trips/presentation/controllers/trips_cubit.dart';
import 'package:tiaw_jung/src/features/trips/presentation/controllers/trips_state.dart';

/// Entry point of the Tiaw Jung module — every trip the signed-in user
/// belongs to, plus Create/Join entry points.
class TripsListPage extends StatefulWidget {
  const TripsListPage({super.key});

  @override
  State<TripsListPage> createState() => _TripsListPageState();
}

class _TripsListPageState extends State<TripsListPage> {
  @override
  void initState() {
    super.initState();
    context.read<TripsCubit>().loadTrips();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: l10n.navBackToSwitcher,
          onPressed: () => context.go('/'),
        ),
        toolbarHeight: 44,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => context.read<TripsCubit>().loadTrips(),
          child: BlocBuilder<TripsCubit, TripsState>(
            builder: (context, state) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                children: [
                  Text(l10n.tripsTitle, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () => context.push(AppRoutes.createTrip),
                          icon: const Icon(Icons.add),
                          label: Text(l10n.tripsCreateButton),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => context.push(AppRoutes.joinTrip),
                          icon: const Icon(Icons.groups_outlined),
                          label: Text(l10n.tripsJoinButton),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (state.status == TripsStatus.loading && state.trips.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (state.status == TripsStatus.error && state.trips.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Center(
                        child: Text(state.error ?? l10n.tripsLoadError, style: TextStyle(color: colors.textMuted)),
                      ),
                    )
                  else if (state.trips.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Column(
                        children: [
                          Icon(Icons.card_travel, size: 40, color: colors.inactive),
                          const SizedBox(height: 14),
                          Text(
                            l10n.tripsEmptyTitle,
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: colors.textPrimary),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            l10n.tripsEmptyBody,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13, color: colors.textMuted),
                          ),
                        ],
                      ),
                    )
                  else
                    for (final trip in state.trips) _TripCard(trip: trip),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _TripCard extends StatelessWidget {
  const _TripCard({required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final dateRange = _dateRangeLabel(trip.startDate, trip.endDate);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: colors.card,
        borderRadius: BorderRadius.circular(18),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => context.push(AppRoutes.tripDetail(trip.id)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(color: colors.primaryTint, borderRadius: BorderRadius.circular(12)),
                  child: Icon(Icons.card_travel, color: colors.primary, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip.name,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: colors.textPrimary),
                      ),
                      if (trip.destination != null || dateRange != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          [if (trip.destination != null) trip.destination!, if (dateRange != null) dateRange]
                              .join(' · '),
                          style: TextStyle(fontSize: 12.5, color: colors.textMuted),
                        ),
                      ],
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: colors.inactive),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _dateRangeLabel(DateTime? start, DateTime? end) {
    if (start == null) return null;
    String fmt(DateTime d) => '${d.day}/${d.month}';
    return end == null ? fmt(start) : '${fmt(start)}–${fmt(end)}';
  }
}
