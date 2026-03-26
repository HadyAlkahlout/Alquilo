import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'app/myApp.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await di.init();

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
        Locale('es'),
      ],
      path: 'assets/lang',
      fallbackLocale: Locale('en'),
      child: MyApp(),
    ),
  );
}