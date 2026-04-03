import 'dart:async';
import 'package:alquilo/core/storage/local_storage.dart';
import 'package:alquilo/features/auth/domain/usecases/resend_otp_usecase.dart';
import 'package:alquilo/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:alquilo/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());

  final VerifyOtpUseCase verifyOtpUseCase = sl();
  final ResendOtpUseCase resendOtpUseCase = sl();

  int seconds = 60;
  Timer? timer;

  void startTimer() {
    seconds = 60;

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds == 0) {
        t.cancel();
      } else {
        seconds--;
        emit(OtpTimerTick(seconds));
      }
    });
  }

  Future<void> verifyCode({
    required String phone,
    required String code,
  }) async {
    emit(OtpLoading());

    try {
      final user = await verifyOtpUseCase(phone, code);

      // 🔥 حفظ التوكن
      await sl<LocalStorage>().setString("token", user.token);

      emit(OtpSuccess());
    } catch (e) {
      emit(OtpError("Invalid code"));
    }
  }

  Future<void> resendCode(String phone) async {
    await resendOtpUseCase(phone);
    startTimer();
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}