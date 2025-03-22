import 'package:firebase/domain/entities/user_profile.dart';

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

class LoadUserProfile extends AuthEvent {
  final String uid;
  LoadUserProfile(this.uid);
}

class UpdateUserProfile extends AuthEvent {
  final UserProfile userProfile;
  UpdateUserProfile(this.userProfile);
}
