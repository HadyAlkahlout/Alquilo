import 'package:alquilo/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alquilo/injection_container.dart';

import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  final ResetPasswordUseCase resetPasswordUseCase = sl();

  bool isPasswordHidden = true;

  void togglePassword() {
    isPasswordHidden = !isPasswordHidden;
    emit(ResetPasswordToggle());
  }

  void reset({
    required String pass,
    required String confirm,
  }) async {
    if (pass.isEmpty || confirm.isEmpty) {
      emit(ResetPasswordError("Fields required"));
      return;
    }

    if (pass != confirm) {
      emit(ResetPasswordError("Passwords do not match"));
      return;
    }

    emit(ResetPasswordLoading());

    await resetPasswordUseCase(pass);

    emit(ResetPasswordSuccess());
  }
}