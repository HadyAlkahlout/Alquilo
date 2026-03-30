import '../repositories/auth_repository.dart';
import '../entities/user.dart';

class VerifyOtpUseCase {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<User> call(String phone, String code) {
    return repository.verifyOtp(phone: phone, code: code);
  }
}