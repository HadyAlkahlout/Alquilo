import 'package:alquilo/core/resources/assets_manager.dart';
import 'package:alquilo/core/resources/strings_manager.dart';
import 'package:alquilo/core/resources/values_manager.dart';
import 'package:alquilo/core/router/routes.dart';
import 'package:alquilo/features/splash/presentation/cubit/splash_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SplashCubit>().start();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is NavigateToOnboarding) {
            context.go(Routes.onboarding);
          } else if (state is NavigateToLogin) {
            context.go(Routes.login);
          } else if (state is NavigateToHome) {
            context.go(Routes.home);
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AssetsManager.logo, width: AppSize.s360),
              Text(
                StringsManager.splashHint.tr(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}