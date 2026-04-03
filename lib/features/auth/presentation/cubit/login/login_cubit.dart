import 'package:alquilo/features/auth/domain/usecases/login_usecase.dart';
import 'package:alquilo/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final LoginUseCase loginUseCase = sl();

  bool isPasswordHidden = true;

  void togglePassword() {
    isPasswordHidden = !isPasswordHidden;
    emit(TogglePasswordVisibility());
  }

  bool isLoginWithEmail = true;

  void toggleLoginMethod() {
    isLoginWithEmail = !isLoginWithEmail;
    emit(ToggleLoginMethod());
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());

    try {
      final user = await loginUseCase(email, password);

      // 🔥 حفظ التوكن
      // sl<LocalStorage>().setString(StorageKeys.token, user.token);

      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}