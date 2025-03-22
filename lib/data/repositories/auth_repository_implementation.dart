import 'package:firebase/domain/entities/user_profile.dart';
import 'package:firebase/domain/repositories/auth_repository.dart';
import 'package:firebase/domain/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserRepository _userRepository;

  AuthRepositoryImplementation(this._userRepository);

  @override
  Future<String> register(String email, String password) async {
    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      String uid = userCredential.user!.uid;

      // ✅ Lưu user vào Firestore thông qua UserRepository
      UserProfile newUser = UserProfile(
        uid: uid,
        email: email,
        phoneNumber: '',
        address: '',
        profilePicture: '',
      );
      await _userRepository.saveUserProfile(newUser);

      return "Đăng ký thành công";
    } catch (e) {
      return "Đăng ký thất bại: ${e.toString()}";
    }
  }

  @override
  Future<String> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Đăng nhập thành công";
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }
}
