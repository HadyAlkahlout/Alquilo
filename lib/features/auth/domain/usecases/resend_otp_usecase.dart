import '../repositories/auth_repository.dart';

class ResendOtpUseCase {
  final AuthRepository repository;

  ResendOtpUseCase(this.repository);

  Future<void> call(String phone) {
    return repository.resendOtp(phone: phone);
  }
}