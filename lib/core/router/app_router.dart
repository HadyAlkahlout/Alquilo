import 'package:alquilo/core/router/routes.dart';
import 'package:alquilo/features/auth/presentation/model/request_otp.dart';
import 'package:alquilo/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:alquilo/features/auth/presentation/pages/get_started_page.dart';
import 'package:alquilo/features/auth/presentation/pages/login_page.dart';
import 'package:alquilo/features/auth/presentation/pages/new_password_page.dart';
import 'package:alquilo/features/auth/presentation/pages/otp_page.dart';
import 'package:alquilo/features/auth/presentation/pages/register_page.dart';
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
      // splash route
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<SplashCubit>()..start(),
          child: const SplashPage(),
        ),
      ),
      // auth routes
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
      GoRoute(
        path: Routes.register,
        builder: (context, state) => RegisterPage()
      ),
      GoRoute(
        path: Routes.otp,
        builder: (context, state) {
          final requestOtp = state.extra as RequestOtp;
          return OtpPage(requestOtp: requestOtp);
        }
      ),
      GoRoute(
        path: Routes.forgetPassword,
        builder: (context, state) {
          return ForgotPasswordPage();
        }
      ),
      GoRoute(
        path: Routes.resetPassword,
        builder: (context, state) {
          return NewPasswordPage();
        }
      ),
      // home route
    ],
  );
}