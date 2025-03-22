import 'package:firebase/domain/entities/user_profile.dart';
import 'package:firebase/domain/repositories/user_repository.dart';

class UpdateUserProfileUseCase {
  final UserRepository userRepository;

  UpdateUserProfileUseCase(this.userRepository);

  Future<void> execute(UserProfile profile) {
    return userRepository.updateUserProfile(profile);
  }
}
