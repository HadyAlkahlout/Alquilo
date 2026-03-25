import 'package:alquilo/core/localization/cubit/locale_cubit.dart';
import 'package:alquilo/core/router/app_router.dart';
import 'package:alquilo/core/theme/cubit/theme_cubit.dart';
import 'package:alquilo/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:alquilo/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ThemeCubit>()),
        BlocProvider(create: (_) => sl<LocaleCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            routerConfig: AppRouter.router,

            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,

            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
          );
        },
      ),
    );
  }
}