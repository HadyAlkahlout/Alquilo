import 'package:alquilo/features/auth/domain/usecases/send_reset_code_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alquilo/injection_container.dart';

import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());

  final SendResetCodeUseCase sendResetCodeUseCase = sl();

  int method = 0;

  void changeMethod(int value) {
    method = value;
    emit(ForgotPasswordMethodChanged());
  }

  void sendCode(String value) async {
    if (value.isEmpty) {
      emit(ForgotPasswordError("Field required"));
      return;
    }

    emit(ForgotPasswordLoading());

    await sendResetCodeUseCase(value);

    emit(ForgotPasswordSuccess(value));
  }
}