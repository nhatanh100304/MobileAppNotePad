import 'package:firebase/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<String> execute(String email, String password) {
    return repository.register(email, password);
  }
}
