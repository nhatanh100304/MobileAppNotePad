import 'package:firebase/domain/entities/failure.dart';
import 'package:firebase/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<String> execute(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "Đăng nhập thành công";
    } on FirebaseAuthException catch (e) {
      return Failure.mapAuthError(e.code, e.message ?? "").message;
    }
  }
}
