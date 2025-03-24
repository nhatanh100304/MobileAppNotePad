import 'package:firebase/domain/entities/failure.dart';
import 'package:firebase/domain/repositories/auth_repository.dart';
import 'package:firebase/domain/usecase/profile/verifycredentials_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginUseCase {
  final AuthRepository repository;
  final VerifyCredentialsUseCase verifyCredentialsUseCase;

  LoginUseCase(this.repository, this.verifyCredentialsUseCase);

  Future<String> call(String email, String password) async {
    // ✅ Kiểm tra tài khoản trước khi đăng nhập
    bool isValid = await verifyCredentialsUseCase(email, password);
    if (!isValid) {
      return "Lỗi đăng nhập: Sai tài khoản hoặc mật khẩu.";
    }

    // ✅ Nếu hợp lệ, thực hiện đăng nhập
    return repository.login(email, password);
  }
}
