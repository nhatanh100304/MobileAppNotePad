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


  AuthBloc(this.loginUseCase, this.registerUseCase, this.logoutUseCase) : super(AuthInitial()) {
    on<LoginUser>((event, emit) async {
      emit(AuthLoading());
      final message = await loginUseCase.execute(event.email, event.password);
      if (message.contains("thành công")) {
        emit(AuthSuccess(message));
      } else {
        emit(AuthFailure(message));
      }
    });

    on<RegisterUser>((event, emit) async {
      emit(AuthLoading());
      final message = await registerUseCase.execute(event.email, event.password);
      if (message.contains("thành công")) {
        emit(AuthSuccess(message));
      } else {
        emit(AuthFailure(message));
      }
    });

    on<LogoutUser>((event, emit) async {
      await logoutUseCase.execute();
      emit(AuthInitial());
    });
  }
}
