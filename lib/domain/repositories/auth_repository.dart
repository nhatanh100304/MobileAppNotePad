
abstract class AuthRepository {
  Future<String> register(String email, String password);
  Future<String> login(String email, String password);
  Future<void> logout();
  Future<bool> verifyCredentials(String email, String password);
}