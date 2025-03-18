import 'package:firebase/domain/entities/failure.dart';
import 'package:firebase/domain/usecase/login_usecase.dart';
import 'package:firebase/domain/usecase/logout_usecase.dart';
import 'package:firebase/domain/usecase/register_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_event.dart';
import 'bloc_state.dart';



class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc(this.loginUseCase, this.registerUseCase, this.logoutUseCase)
      : super(AuthInitial()) {
    on<LoginUser>((event, emit) async {
      emit(AuthLoading());
      final result = await loginUseCase.execute(event.email, event.password);

      if (result == "Đăng nhập thành công") {
        emit(AuthSuccess("Bạn đã đăng nhập thành công!", event.email));
      } else {
        emit(AuthFailure(Failure.mapLoginError(result).message));
      }
    });

    on<RegisterUser>((event, emit) async {
      emit(AuthLoading());
      final result = await registerUseCase.execute(event.email, event.password);

      if (result == "Đăng ký thành công") {
        emit(AuthSuccess("Đăng ký thành công! Hãy đăng nhập.", event.email));
      } else {
        emit(AuthFailure(Failure.mapRegisterError(result).message));
      }
    });

    on<LogoutUser>((event, emit) async {
      await logoutUseCase.execute();
      emit(AuthInitial());
    });
  }
}