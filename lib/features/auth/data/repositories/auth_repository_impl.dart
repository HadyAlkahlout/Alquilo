import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    return await remote.login(email, password);
  }

  @override
  Future<User> register({
    required String name,
    required String email,
    required String password,
  }) async {
    return await remote.register(name, email, password);
  }

  @override
  Future<User> verifyOtp({
    required String phone,
    required String code,
  }) async {
    return await remote.verifyOtp(phone, code);
  }

  @override
  Future<void> resendOtp({required String phone}) async {
    await remote.resendOtp(phone);
  }

  @override
  Future<void> sendResetCode({
    required String phoneMail,
  }) async {
    await remote.sendResetCode(phoneMail);
  }

  @override
  Future<void> resetPassword({
    required String password,
  }) async {
    await remote.resetPassword(password);
  }
}