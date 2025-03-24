import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase/domain/entities/user_profile.dart';
import 'package:firebase/presentation/Bloc/bloc.dart';
import 'package:firebase/presentation/Bloc/bloc_event.dart';
import 'package:firebase/presentation/Bloc/bloc_state.dart';

class EditProfilePage extends StatefulWidget {
  final String? uid;

  const EditProfilePage({super.key, required this.uid});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.uid != null && widget.uid!.isNotEmpty) {
      context.read<AuthBloc>().add(LoadUserProfile(widget.uid!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Nền tối
      appBar: AppBar(
        title: const Text("Chỉnh sửa hồ sơ"),
        backgroundColor: Colors.blueGrey[900],
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UserProfileUpdated) {
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
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserProfileLoaded) {
            emailController.text = state.userProfile.email ?? "";
            phoneController.text = state.userProfile.phoneNumber ?? "";
            addressController.text = state.userProfile.address ?? "";

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildTextField(emailController, "Email", Icons.email),
                  _buildTextField(phoneController, "Số điện thoại", Icons.phone),
                  _buildTextField(addressController, "Địa chỉ", Icons.home),
                  const SizedBox(height: 30),

                  // Nút Lưu và Hủy
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.save),
                        onPressed: () {
                          UserProfile updatedProfile = UserProfile(
                            uid: widget.uid ?? "",
                            email: emailController.text,
                            phoneNumber: phoneController.text,
                            address: addressController.text,
                            profilePicture: state.userProfile.profilePicture ?? "",
                          );
                          context.read<AuthBloc>().add(UpdateUserProfile(updatedProfile));
                        },
                        style: _buttonStyle(Colors.blueAccent),
                        label: const Text("Lưu"),
                      ),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.cancel),
                        onPressed: () => Navigator.pop(context),
                        style: _buttonStyle(Colors.grey),
                        label: const Text("Hủy"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (state is AuthFailure) {
            return Center(
              child: Text(
                state.error,
                style: const TextStyle(color: Colors.redAccent, fontSize: 16),
              ),
            );
          }
          return const Center(
            child: Text(
              "Không có dữ liệu hồ sơ.",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        },
      ),
    );
  }

  // Hàm tạo TextField có Icon
  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.white70),
          filled: true,
          fillColor: Colors.blueGrey[800],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          labelStyle: const TextStyle(color: Colors.white70),
        ),
      ),
    );
  }

  // Hàm style cho nút bấm
  ButtonStyle _buttonStyle(Color color) {
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
