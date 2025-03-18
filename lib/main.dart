import 'package:firebase/domain/usecase/logout_usecase.dart';
import 'package:firebase/presentation/Bloc/bloc.dart';
import 'package:firebase/presentation/view/home_page.dart';
import 'package:firebase/presentation/view/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/usecase/login_usecase.dart';
import 'firebase_options.dart';
import 'data/repositories/auth_repository_implementation.dart';

import 'domain/usecase/register_usecase.dart';


import 'presentation/view/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            LoginUseCase(AuthRepositoryImplementation()),
            RegisterUseCase(AuthRepositoryImplementation()),
            LogoutUseCase(AuthRepositoryImplementation()),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/login",
        routes: {
          "/login": (context) => LoginPage(),
          "/register": (context) => RegisterPage(),
          "/home": (context) => HomePage(),
        },
      ),
    );
  }
}
