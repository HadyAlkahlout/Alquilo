import 'package:alquilo/features/auth/domain/usecases/register_usecase.dart';
import 'package:alquilo/features/auth/domain/usecases/resend_otp_usecase.dart';
import 'package:alquilo/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
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

  // DataSource
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // UseCase
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(sl()));
  sl.registerLazySingleton(() => ResendOtpUseCase(sl()));
}
