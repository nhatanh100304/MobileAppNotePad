import 'package:firebase/domain/repositories/auth_repository.dart';

class VerifyCredentialsUseCase {
  final AuthRepository repository;

  VerifyCredentialsUseCase(this.repository);

  Future<bool> call(String email, String password) {
    return repository.verifyCredentials(email, password);
  }
}
