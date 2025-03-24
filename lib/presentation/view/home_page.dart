import 'package:firebase/presentation/Bloc/bloc.dart';
import 'package:firebase/presentation/Bloc/bloc_event.dart';
import 'package:firebase/presentation/Bloc/bloc_state.dart';
import 'package:firebase/presentation/view/edit_profile_page.dart';
import 'package:firebase/presentation/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'note_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    return Scaffold(
      backgroundColor: Colors.grey[900], // Nền tối nhẹ
      appBar: AppBar(
        title: const Text(
          "Trang Chủ",
          style: TextStyle(
            fontSize: 22, // 🔹 Tăng kích thước chữ
            fontWeight: FontWeight.bold, // 🔹 Làm chữ đậm hơn
          ),
        ),
        backgroundColor: Colors.blueGrey[900], // 🔹 Đổi màu nền để nổi bật hơn
        elevation: 4, // 🔹 Tạo hiệu ứng nổi
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              if (authBloc.currentUid != null && authBloc.currentUid!.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EditProfilePage(uid: authBloc.currentUid!),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Lỗi: Không tìm thấy UID!")),
                );
              }
            },
          ),

          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            onPressed: () {
              context.read<AuthBloc>().add(LogoutUser());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),

      // 🔹 Nội dung chính
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 🎉 Lời chào
                Text(
                  state is AuthSuccess
                      ? "Chào mừng ${state.uid}!"
                      : "Chào mừng bạn!",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),

                // 🔥 Nút mở Notepad lớn hơn
                ElevatedButton.icon(
                  icon: const Icon(Icons.note, size: 30),
                  label: const Text(
                    "Mở Notepad",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (authBloc.currentUid != null &&
                        authBloc.currentUid!.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NotepadListPage(userId: authBloc.currentUid!),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Lỗi: Không tìm thấy UID!")),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
