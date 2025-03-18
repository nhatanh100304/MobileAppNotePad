class UserProfile {
  final String email;
  final String phoneNumber;
  final String address;
  final String profilePicture;

  UserProfile({
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.profilePicture,
  });

  factory UserProfile.empty() {
    return UserProfile(
      email: '',
      phoneNumber: '',
      address: '',
      profilePicture: '',
    );
  }
}
