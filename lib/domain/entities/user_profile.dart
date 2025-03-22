class UserProfile {
  final String uid;
  final String email;
  final String phoneNumber;
  final String address;
  final String profilePicture;

  UserProfile({
    required this.uid,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.profilePicture,
  });

  factory UserProfile.empty() {
    return UserProfile(
      uid: '',
      email: '',
      phoneNumber: '',
      address: '',
      profilePicture: '',
    );
  }


  factory UserProfile.fromMap(Map<String, dynamic> data) {
    return UserProfile(
      uid: data['uid'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      address: data['address'] ?? '',
      profilePicture: data['profilePicture'] ?? '',
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'profilePicture': profilePicture,
    };
  }
}
