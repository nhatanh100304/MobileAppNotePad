import 'package:firebase/domain/entities/failure.dart';
import 'package:firebase/domain/entities/user_profile.dart';
import 'package:firebase/domain/usecase/profile/get_user_profile_usecase.dart';
import 'package:firebase/domain/usecase/login_usecase.dart';
import 'package:firebase/domain/usecase/logout_usecase.dart';
import 'package:firebase/domain/usecase/register_usecase.dart';
import 'package:firebase/domain/usecase/profile/update_user_profile_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_event.dart';
import 'bloc_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final GetUserProfileUseCase getUserProfileUseCase;
  final UpdateUserProfileUseCase updateUserProfileUseCase;

  String? currentUid; // Lưu UID của user hiện tại

  AuthBloc(
      this.loginUseCase,
      this.registerUseCase,
      this.logoutUseCase,
      this.getUserProfileUseCase,
      this.updateUserProfileUseCase,
      ) : super(AuthInitial()) {

    // 🔹 ĐĂNG NHẬP
    on<LoginUser>((event, emit) async {
      emit(AuthLoading());
      final uid = await loginUseCase.call(event.email, event.password);

      if (uid.isNotEmpty && !uid.startsWith("Lỗi đăng nhập")) {
        currentUid = uid;
        emit(AuthSuccess("Bạn đã đăng nhập thành công!", uid));

        try {
          final userProfile = await getUserProfileUseCase.execute(uid);
          emit(UserProfileLoaded(userProfile));
        } catch (e) {
          emit(AuthFailure("Không thể tải hồ sơ người dùng."));
        }
      } else {
        emit(AuthFailure(uid)); // ✅ Trả về lỗi chi tiết
      }
    });

    // 🔹 ĐĂNG KÝ
    on<RegisterUser>((event, emit) async {
      emit(AuthLoading());
      final result = await registerUseCase.execute(event.email, event.password);

      if (result == "Đăng ký thành công") {
        emit(AuthSuccess("Đăng ký thành công! Hãy đăng nhập.", ''));
      } else {
        emit(AuthFailure(Failure.mapRegisterError(result).message));
      }
    });

    // 🔹 ĐĂNG XUẤT
    on<LogoutUser>((event, emit) async {
      await logoutUseCase.execute();
      currentUid = null;
      emit(AuthInitial());
    });

    // 🔹 TẢI HỒ SƠ NGƯỜI DÙNG
    on<LoadUserProfile>((event, emit) async {
      emit(AuthLoading());
      try {
        final userProfile = await getUserProfileUseCase.execute(event.uid);
        emit(UserProfileLoaded(userProfile));
      } catch (e) {
        emit(AuthFailure("Không thể tải hồ sơ người dùng."));
      }
    });

    // 🔹 CẬP NHẬT HỒ SƠ NGƯỜI DÙNG
    on<UpdateUserProfile>((event, emit) async {
      emit(AuthLoading());
      try {
        await updateUserProfileUseCase.execute(event.userProfile);
        emit(UserProfileUpdated("Cập nhật hồ sơ thành công!"));
      } catch (e) {
        emit(AuthFailure("Cập nhật hồ sơ thất bại."));
      }
    });
  }
}
