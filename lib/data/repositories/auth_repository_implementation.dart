import 'package:firebase/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';



class AuthRepositoryImplementation implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<String> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
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