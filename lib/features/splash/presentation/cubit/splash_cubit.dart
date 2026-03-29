import 'package:alquilo/core/resources/values_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/storage/local_storage.dart';
import '../../../../../core/constants/storage_keys.dart';

import '../../../../../injection_container.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final LocalStorage storage = sl();

  SplashCubit() : super(SplashInitial());

  Future<void> start() async {
    emit(SplashLoading());

    await Future.delayed(const Duration(seconds: AppDuration.splashDelay));

    final seenOnboarding = storage.getBool(StorageKeys.onboardingSeen);

    final token = storage.getString(StorageKeys.token);

    if (!seenOnboarding) {
      emit(NavigateToOnboarding());
    } else if (token == null || token.isEmpty) {
      emit(NavigateToLogin());
    } else {
      emit(NavigateToHome());
    }
  }
}