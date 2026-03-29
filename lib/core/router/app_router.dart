import 'package:alquilo/core/router/routes.dart';
import 'package:alquilo/features/auth/presentation/pages/get_started_page.dart';
import 'package:alquilo/features/auth/presentation/pages/login_page.dart';
import 'package:alquilo/features/onbarding/presentation/pages/onboarding_page.dart';
import 'package:alquilo/features/splash/presentation/pages/splash_page.dart';
import 'package:alquilo/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash/presentation/cubit/splash_cubit.dart';

class AppRouter {

  static final router = GoRouter(
    initialLocation: Routes.splash,
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<SplashCubit>()..start(),
          child: const SplashPage(),
        ),
      ),
      GoRoute(
        path: Routes.onboarding,
        builder: (context, state) => OnboardingPage()
      ),
      GoRoute(
        path: Routes.getStarted,
        builder: (context, state) => GetStartedPage()
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => LoginPage()
      ),
    ],
  );
}