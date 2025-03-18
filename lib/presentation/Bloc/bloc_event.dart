abstract class AuthEvent {}

class LoginUser extends AuthEvent {
  final String email;
  final String password;

  LoginUser(this.email, this.password);
}

class RegisterUser extends AuthEvent {
  final String email;
  final String password;

  RegisterUser(this.email, this.password);
}

class LogoutUser extends AuthEvent {}
