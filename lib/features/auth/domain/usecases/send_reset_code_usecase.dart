import 'package:alquilo/features/auth/domain/repositories/auth_repository.dart';

class SendResetCodeUseCase {
  final AuthRepository repository;

  SendResetCodeUseCase(this.repository);

  Future<void> call(String phoneMail) {
    return repository.sendResetCode(phoneMail: phoneMail);
  }
}