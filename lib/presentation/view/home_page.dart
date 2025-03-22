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
      appBar: AppBar(
        title: const Text("Trang Chủ"),
        actions: [
          // 🔹 Nút vào Profile
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              if (authBloc.currentUid != null && authBloc.currentUid!.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(uid: authBloc.currentUid!),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Lỗi: Không tìm thấy UID!")),
                );
              }
            },
          ),

          // 🔹 Nút mở Notepad
          IconButton(
            icon: const Icon(Icons.note),
            onPressed: () {
              if (authBloc.currentUid != null && authBloc.currentUid!.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotepadListPage(userId: authBloc.currentUid!),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Lỗi: Không tìm thấy UID!")),
                );
              }
            },
          ),

          // 🔹 Nút Logout
          IconButton(
            icon: const Icon(Icons.logout),
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
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthSuccess) {
            return Center(child: Text("Chào mừng ${state.uid}!"));
          } else {
            return const Center(child: Text("Chào mừng bạn!"));
          }
        },
      ),
    );
  }
}
