import 'package:alquilo/core/constants/storage_keys.dart';
import 'package:alquilo/core/storage/local_storage.dart';
import 'package:alquilo/features/auth/domain/usecases/register_usecase.dart';
import 'package:alquilo/injection_container.dart';

import 'register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  final RegisterUseCase registerUseCase = sl();

  bool isPasswordHidden = true;
  bool isChecked = false;

  void togglePassword() {
    isPasswordHidden = !isPasswordHidden;
    emit(TogglePasswordVisibility());
  }

  void toggleTerms(bool value) {
    isChecked = value;
    emit(ToggleTerms());
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    if (!isChecked) {
      emit(RegisterError("Accept terms first"));
      return;
    }

    emit(RegisterLoading());

    try {
      final user =
      await registerUseCase(name, email, password);

      // 🔥 حفظ التوكن
      await sl<LocalStorage>()
          .setString(StorageKeys.token, user.token);

      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterError("Something went wrong"));
    }
  }
}
