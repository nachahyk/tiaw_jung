/// Route path constants for the Tiaw Jung mini-app, namespaced under
/// `/tiaw-jung` so they can't collide with another mini-app's routes.
class AppRoutes {
  const AppRoutes._();

  static const String splash = '/tiaw-jung';
  static const String trips = '/tiaw-jung/trips';
  static const String createTrip = '/tiaw-jung/trips/new';
  static const String joinTrip = '/tiaw-jung/trips/join';

  static const String tripDetailPath = '/tiaw-jung/trips/:id';
  static String tripDetail(String id) => '/tiaw-jung/trips/$id';

  static const String stopNewPath = '/tiaw-jung/trips/:id/stops/new';
  static String stopNew(String tripId) => '/tiaw-jung/trips/$tripId/stops/new';

  static const String stopEditPath = '/tiaw-jung/trips/:id/stops/:stopId/edit';
  static String stopEdit(String tripId, String stopId) => '/tiaw-jung/trips/$tripId/stops/$stopId/edit';
}
