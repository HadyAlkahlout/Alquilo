 import 'package:alquilo/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase {
   final AuthRepository repository;

   ResetPasswordUseCase(this.repository);

   Future<void> call(String password) {
     return repository.resetPassword(password: password);
   }
 }