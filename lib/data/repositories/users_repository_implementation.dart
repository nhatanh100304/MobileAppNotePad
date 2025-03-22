import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/domain/entities/user_profile.dart';
import 'package:firebase/domain/repositories/user_repository.dart';


class UserRepositoryImplementation implements UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<UserProfile> getUserProfile(String uid) async {
    try {
      // 🔹 Kiểm tra nếu collection 'users' rỗng, tự tạo một user mặc định
      await _ensureUsersCollectionExists();

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
      // 🔹 Đảm bảo collection tồn tại trước khi lưu dữ liệu
      await _ensureUsersCollectionExists();

      await _firestore.collection('users').doc(profile.uid).set(profile.toMap());
    } catch (e) {
      throw Exception("Lỗi khi lưu thông tin người dùng: ${e.toString()}");
    }
  }

  @override
  Future<void> updateUserProfile(UserProfile profile) async {
    await _firestore.collection('users').doc(profile.uid).update(profile.toMap());
  }

  @override
  Future<void> deleteUserProfile(String uid) async {
    await _firestore.collection('users').doc(uid).delete();
  }

  /// 🔹 Phương thức kiểm tra collection 'users' có tồn tại hay không
  Future<void> _ensureUsersCollectionExists() async {
    final collectionRef = _firestore.collection("users");
    final snapshot = await collectionRef.limit(1).get();

    if (snapshot.docs.isEmpty) {
      // 🔹 Nếu collection rỗng, tạo một user mặc định để duy trì collection
      await collectionRef.doc("default_user").set({
        "uid": "default_user",
        "name": "Default User",
        "email": "default@example.com",
        "createdAt": Timestamp.now(),
      });
    }
  }
}
