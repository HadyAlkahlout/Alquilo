import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login({
    required String email,
    required String password,
  });
  Future<User> register({
    required String name,
    required String email,
    required String password,
  });
  Future<User> verifyOtp({
    required String phone,
    required String code,
  });
  Future<void> resendOtp({
    required String phone,
  });
}