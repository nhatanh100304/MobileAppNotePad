abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;
  final String email;

  AuthSuccess(this.message, this.email);
}

class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}
