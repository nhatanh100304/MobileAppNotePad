import 'package:firebase/domain/entities/user_profile.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {
  final String message;
  final String uid;


  AuthSuccess(this.message, this.uid);
}
class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}
class UserProfileLoaded extends AuthState {
  final UserProfile userProfile;
  UserProfileLoaded(this.userProfile);
}
class UserProfileUpdated extends AuthState {
  final String message;
  UserProfileUpdated(this.message);
}