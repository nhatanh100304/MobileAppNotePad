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
  bool _obscurePassword = true; // Trạng thái ẩn/hiện mật khẩu

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Nền tối
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🔥 Tiêu đề đăng ký
              Text(
                "Đăng Ký",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),

              // 🔹 Email Input
              _buildTextField(
                controller: _emailController,
                label: "Email",
                icon: Icons.email,
              ),
              const SizedBox(height: 15),

              // 🔹 Password Input với nút ẩn/hiện
              _buildTextField(
                controller: _passwordController,
                label: "Mật khẩu",
                icon: Icons.lock,
                isPassword: true,
                obscureText: _obscurePassword,
                toggleObscure: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              const SizedBox(height: 25),

              // 🔹 Nút Đăng Ký & Hiển thị trạng thái
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else if (state is AuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is AuthLoading
                        ? null
                        : () {
                      final email = _emailController.text.trim();
                      final password = _passwordController.text.trim();
                      if (email.isNotEmpty && password.isNotEmpty) {
                        context.read<AuthBloc>().add(RegisterUser(email, password));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      state is AuthLoading ? "Đang xử lý..." : "Đăng ký",
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // 🔹 Quay lại đăng nhập
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Đã có tài khoản? Đăng nhập",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🎨 Hàm tạo TextField tùy chỉnh
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? toggleObscure,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.white70,
          ),
          onPressed: toggleObscure,
        )
            : null,
        filled: true,
        fillColor: Colors.grey[900], // Màu nền ô nhập liệu
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
