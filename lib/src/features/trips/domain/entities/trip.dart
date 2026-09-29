/// A trip a group of people is planning together. [joinCode] is how new
/// members find it — shown on the trip detail page for the organizer to
/// share.
class Trip {
  const Trip({
    required this.id,
    required this.name,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.joinCode,
    required this.isOrganizer,
  });

  final String id;
  final String name;
  final String? destination;
  final DateTime? startDate;
  final DateTime? endDate;
  final String joinCode;

  /// Whether the current user organizes this trip (vs. a plain member) —
  /// resolved server-side from `trip_members.role`, not a client guess.
  final bool isOrganizer;
}
