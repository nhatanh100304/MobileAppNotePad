class Failure {
  final String message;

  Failure(this.message);

  static Failure mapAuthError(String code, String message) {
    switch (code) {
      case 'user-not-found':
        return Failure("Tài khoản không tồn tại");
      case 'wrong-password':
        return Failure("Sai mật khẩu");
      case 'weak-password':
        return Failure("Mật khẩu quá yếu, vui lòng chọn mật khẩu mạnh hơn.");
      case 'email-already-in-use':
        return Failure("Email này đã được đăng ký trước đó.");
      default:
        return Failure("Lỗi: $message");
    }
  }

  static Failure mapLoginError(String message) {
    switch (message) {
      case "Sai mật khẩu":
        return Failure("Mật khẩu không đúng, vui lòng thử lại.");
      case "Tài khoản không tồn tại":
        return Failure("Email này chưa được đăng ký.");
      default:
        return Failure("Đăng nhập thất bại: $message");
    }
  }

  static Failure mapRegisterError(String message) {
    if (message.contains("đã tồn tại")) {
      return Failure("Email này đã được đăng ký trước đó.");
    } else if (message.contains("mật khẩu yếu")) {
      return Failure("Mật khẩu quá yếu, vui lòng chọn mật khẩu mạnh hơn.");
    } else {
      return Failure("Đăng ký thất bại: $message");
    }
  }
}
