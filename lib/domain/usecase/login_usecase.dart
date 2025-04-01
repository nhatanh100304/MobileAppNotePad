
import 'package:firebase/domain/repositories/auth_repository.dart';
import 'package:firebase/domain/usecase/profile/verifycredentials_usecase.dart';


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
    return repository.login(email, password);
  }
}
