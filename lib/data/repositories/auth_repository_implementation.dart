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
      UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // ✅ Lấy UID của user sau khi đăng nhập thành công
      String uid = userCredential.user!.uid;
      return uid;
    } on FirebaseAuthException catch (e) {
      // ✅ Xử lý lỗi chi tiết hơn
      if (e.code == 'user-not-found') {
        return "Lỗi đăng nhập: Tài khoản không tồn tại.";
      } else if (e.code == 'wrong-password') {
        return "Lỗi đăng nhập: Sai mật khẩu.";
      } else {
        return "Lỗi đăng nhập: ${e.message}";
      }
    } catch (e) {
      return "Lỗi đăng nhập: ${e.toString()}";
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }



  @override
  Future<bool> verifyCredentials(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await _auth.signOut(); // ✅ Đăng xuất ngay để không giữ phiên
      return true;
    } on FirebaseAuthException catch (e) {
      return false; // ❌ Sai tài khoản hoặc mật khẩu
    } catch (e) {
      throw Exception("Lỗi xác thực: ${e.toString()}");
    }
  }
}
