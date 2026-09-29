enum TripRole { organizer, member }

/// One member of a trip — the profile fields are joined in from `profiles`
/// at read time so the member list can show a name without a second query.
class TripMember {
  const TripMember({
    required this.userId,
    required this.role,
    required this.fullName,
    required this.email,
  });

  final String userId;
  final TripRole role;
  final String? fullName;
  final String? email;
}
