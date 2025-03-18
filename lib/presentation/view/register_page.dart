import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/bloc.dart';
import '../Bloc/bloc_event.dart';
import '../Bloc/bloc_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Đăng Ký")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Mật khẩu"),
            ),
            SizedBox(height: 20),

            // BlocBuilder để cập nhật UI dựa trên trạng thái
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return CircularProgressIndicator();
                } else if (state is AuthSuccess) {
                  return Text(
                    state.message,
                    style: TextStyle(color: Colors.green),
                  );
                } else if (state is AuthFailure) {
                  return Text(
                    state.error,
                    style: TextStyle(color: Colors.red),
                  );
                }
                return ElevatedButton(
                  onPressed: () {
                    final email = _emailController.text.trim();
                    final password = _passwordController.text.trim();
                    if (email.isNotEmpty && password.isNotEmpty) {
                      context.read<AuthBloc>().add(RegisterUser(email, password));
                    }
                  },
                  child: Text("Đăng ký"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
