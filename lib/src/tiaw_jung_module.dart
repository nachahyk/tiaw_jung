import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:core_infra/core_infra.dart';
import 'package:jung_studio_auth/jung_studio_auth.dart';

import 'core/widgets/tj_theme.dart';
import 'features/itinerary/domain/repositories/itinerary_repository.dart';
import 'features/itinerary/presentation/controllers/itinerary_cubit.dart';
import 'features/itinerary/presentation/pages/stop_form_page.dart';
import 'features/trips/domain/repositories/trip_repository.dart';
import 'features/trips/presentation/controllers/trip_detail_cubit.dart';
import 'features/trips/presentation/pages/create_trip_page.dart';
import 'features/trips/presentation/pages/join_trip_page.dart';
import 'features/trips/presentation/pages/trip_detail_page.dart';
import 'features/trips/presentation/pages/trips_list_page.dart';
import 'routes/app_routes.dart';

/// Tiaw Jung's [AppModule] implementation — the trip-planning mini-app.
///
/// Owns this mini-app's whole route tree, namespaced under `/tiaw-jung` so
/// it can't collide with AimJung's. Every route wraps its page in [TjTheme]
/// so Tiaw Jung renders in its own mid-century-blue theme regardless of
/// what theme the shell (or another installed module) applies globally —
/// see the theming note on [TjTheme] itself.
///
/// Trip planning has no guest/anonymous concept (a trip needs real
/// identities to invite and split with), so — unlike AimJung, which lets
/// guests browse the menu — every route here requires sign-in.
class TiawJungModule implements AppModule {
  TiawJungModule({
    required this.authCubit,
    required this.tripRepository,
    required this.itineraryRepository,
  });

  final AuthCubit authCubit;
  final TripRepository tripRepository;
  final ItineraryRepository itineraryRepository;

  @override
  String get id => 'tiaw_jung';

  @override
  String get displayName => 'Tiaw Jung';

  @override
  IconData get icon => Icons.card_travel;

  @override
  String get entryPath => AppRoutes.trips;

  String? _requireSignedIn(BuildContext context, GoRouterState state) {
    return authCubit.state is AuthAuthenticated ? null : '/login';
  }

  @override
  List<RouteBase> get routes => [
        // TripsCubit itself is app-wide (provided once alongside every other
        // top-level cubit in `App`'s root MultiBlocProvider, in apps/jung_studio)
        // rather than created here — a `context.push` to a sibling route
        // builds a fresh widget subtree with no access to a BlocProvider
        // placed inside a *different* route's builder, so a cubit shared
        // across trips/createTrip/joinTrip has to live above all of them.
        GoRoute(
          path: AppRoutes.trips,
          redirect: _requireSignedIn,
          builder: (context, state) => const TjTheme(child: TripsListPage()),
        ),
        GoRoute(
          path: AppRoutes.createTrip,
          redirect: _requireSignedIn,
          builder: (context, state) => const TjTheme(child: CreateTripPage()),
        ),
        GoRoute(
          path: AppRoutes.joinTrip,
          redirect: _requireSignedIn,
          builder: (context, state) => const TjTheme(child: JoinTripPage()),
        ),
        // Trip detail and its two stop-form routes share one TripDetailCubit
        // + ItineraryCubit instance via ShellRoute — a stop added/edited/
        // deleted on the form immediately reflects on trip detail once you
        // pop back, since both routes are watching the very same cubits
        // rather than each getting a fresh one from a separate `context.push`.
        ShellRoute(
          builder: (context, state, child) {
            final tripId = state.pathParameters['id']!;
            return TjTheme(
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => TripDetailCubit(tripRepository)..loadTrip(tripId)),
                  BlocProvider(create: (_) => ItineraryCubit(itineraryRepository)..loadStops(tripId)),
                ],
                child: child,
              ),
            );
          },
          routes: [
            GoRoute(
              path: AppRoutes.tripDetailPath,
              redirect: _requireSignedIn,
              builder: (context, state) => TripDetailPage(tripId: state.pathParameters['id']!),
            ),
            GoRoute(
              path: AppRoutes.stopNewPath,
              redirect: _requireSignedIn,
              builder: (context, state) => StopFormPage(tripId: state.pathParameters['id']!),
            ),
            GoRoute(
              path: AppRoutes.stopEditPath,
              redirect: _requireSignedIn,
              builder: (context, state) => StopFormPage(
                tripId: state.pathParameters['id']!,
                stopId: state.pathParameters['stopId'],
              ),
            ),
          ],
        ),
      ];

  @override
  Future<void> initialize() async {}

  @override
  Future<void> dispose() async {}
}
