/// Tiaw Jung: the trip-planning mini-app.
///
/// Same feature-first Clean Architecture as AimJung internally (trips,
/// itinerary — each with data/domain/presentation layers and its own
/// Cubits). Until the shell builds this lazily via `AppModule.initialize`
/// (still Phase 7 work, same as AimJung), `apps/jung_studio` constructs
/// this mini-app's repositories/cubits eagerly itself, which is why this
/// barrel exports those concrete types directly instead of hiding them
/// behind the module.
library;

export 'src/tiaw_jung_module.dart';
export 'src/routes/app_routes.dart';
export 'src/theme/app_theme.dart';
export 'src/theme/app_colors.dart';

export 'src/features/trips/data/datasources/trip_remote_data_source.dart';
export 'src/features/trips/data/repositories/trip_repository_impl.dart';
export 'src/features/trips/domain/repositories/trip_repository.dart';
export 'src/features/trips/presentation/controllers/trips_cubit.dart';

export 'src/features/itinerary/data/datasources/itinerary_remote_data_source.dart';
export 'src/features/itinerary/data/repositories/itinerary_repository_impl.dart';
export 'src/features/itinerary/domain/repositories/itinerary_repository.dart';
