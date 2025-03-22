import 'package:firebase/domain/entities/user_profile.dart';

abstract class UserRepository {
  Future<UserProfile> getUserProfile(String uid);
  Future<void> saveUserProfile(UserProfile profile);
  Future<void> updateUserProfile(UserProfile profile);
  Future<void> deleteUserProfile(String uid);
}
