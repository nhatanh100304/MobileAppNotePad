import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/domain/entities/user_profile.dart';
import 'package:firebase/domain/repositories/user_repository.dart';

class UserRepositoryImplementation implements UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<UserProfile> getUserProfile(String uid) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();

      if (userDoc.exists) {
        return UserProfile.fromMap(userDoc.data() as Map<String, dynamic>);
      } else {
        throw Exception("Người dùng không tồn tại");
      }
    } catch (e) {
      throw Exception("Lỗi khi lấy thông tin người dùng: ${e.toString()}");
    }
  }

  @override
  Future<void> saveUserProfile(UserProfile profile) async {
    try {
      await _firestore.collection('users').doc(profile.uid).set(profile.toMap());
    } catch (e) {
      throw Exception("Lỗi khi lưu thông tin người dùng: ${e.toString()}");
    }
  }

  @override
  Future<void> updateUserProfile(UserProfile profile) async {
    try {
      await _firestore.collection('users').doc(profile.uid).update(profile.toMap());
    } catch (e) {
      throw Exception("Lỗi khi cập nhật thông tin người dùng: ${e.toString()}");
    }
  }

  @override
  Future<void> deleteUserProfile(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).delete();
    } catch (e) {
      throw Exception("Lỗi khi xóa thông tin người dùng: ${e.toString()}");
    }
  }
}
