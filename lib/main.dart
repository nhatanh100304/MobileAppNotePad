import 'package:firebase/domain/repositories/user_repository.dart';
import 'package:firebase/domain/usecase/logout_usecase.dart';
import 'package:firebase/presentation/Bloc/bloc.dart';
import 'package:firebase/presentation/view/home_page.dart';
import 'package:firebase/presentation/view/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/users_repository_implementation.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecase/get_user_profile_usecase.dart';
import 'domain/usecase/login_usecase.dart';
import 'domain/usecase/update_user_profile_usecase.dart';
import 'firebase_options.dart';
import 'data/repositories/auth_repository_implementation.dart';

import 'domain/usecase/register_usecase.dart';

import 'presentation/view/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final userRepository = UserRepositoryImplementation();
  final authRepository = AuthRepositoryImplementation(userRepository);

  runApp(MyApp(authRepository: authRepository, userRepository: userRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  const MyApp({super.key, required this.authRepository, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            LoginUseCase(authRepository),
            RegisterUseCase(authRepository),
            LogoutUseCase(authRepository),
            GetUserProfileUseCase(userRepository),
            UpdateUserProfileUseCase(userRepository),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/login",
        routes: {
          "/login": (context) => const LoginPage(),
          "/register": (context) => const RegisterPage(),
          "/home": (context) => const HomePage(),
        },
      ),
    );
  }
}
