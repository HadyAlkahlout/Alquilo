import 'package:flutter_bloc/flutter_bloc.dart';

import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());

  int method = 0;

  void changeMethod(int value) {
    method = value;
    emit(ForgotPasswordMethodChanged());
  }

  Future<void> sendCode(String value) async {
    if (value.isEmpty) {
      emit(ForgotPasswordError("Field required"));
      return;
    }

    emit(ForgotPasswordLoading());

    await Future.delayed(const Duration(seconds: 2));

    emit(ForgotPasswordSuccess(value));
  }
}