import 'package:firebase/domain/entities/user_profile.dart';
import 'package:firebase/domain/repositories/user_repository.dart';

class GetUserProfileUseCase {
  final UserRepository userRepository;

  GetUserProfileUseCase(this.userRepository);

  Future<UserProfile> execute(String uid) {
    return userRepository.getUserProfile(uid);
  }
}
