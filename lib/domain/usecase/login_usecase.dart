import 'package:firebase/domain/entities/failure.dart';
import 'package:firebase/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<String> execute(String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user?.uid ?? "Đăng nhập thất bại";
    } on FirebaseAuthException catch (e) {
      return Failure.mapAuthError(e.code, e.message ?? "").message;
    }
  }
}
