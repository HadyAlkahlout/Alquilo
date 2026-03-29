import 'package:alquilo/core/resources/colors_manager.dart';
import 'package:alquilo/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: ColorManager.primaryColor,
    scaffoldBackgroundColor: ColorManager.backgroundLight,
    textTheme: TextTheme(),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: ColorManager.lightGrey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s24),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primaryColor,
        foregroundColor: ColorManager.textDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s24),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorManager.primaryColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s12),
        borderSide: BorderSide(color: ColorManager.lightGrey),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: ColorManager.primaryColor,
    scaffoldBackgroundColor: ColorManager.backgroundDark,
    textTheme: TextTheme(),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: ColorManager.lightGrey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s24),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primaryColor,
        foregroundColor: ColorManager.textLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s24),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorManager.primaryColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s12),
        borderSide: BorderSide(color: ColorManager.lightGrey),
      ),
    ),
  );
}
