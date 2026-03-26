import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/splash/presentation/cubit/splash_cubit.dart';
import 'core/localization/cubit/locale_cubit.dart';
import 'core/network/api_client.dart';
import 'core/network/dio_factory.dart';
import 'core/storage/local_storage.dart';
import 'core/theme/cubit/theme_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Dio
  final dio = DioFactory.create();
  sl.registerLazySingleton(() => ApiClient(dio));

  // SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);
  sl.registerLazySingleton(() => LocalStorage(sl()));

  sl.registerFactory(() => ThemeCubit());
  sl.registerFactory(() => LocaleCubit());
  sl.registerFactory(() => SplashCubit());
}