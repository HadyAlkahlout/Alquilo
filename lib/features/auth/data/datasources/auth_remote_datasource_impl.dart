import 'dart:async';
import '../models/user_model.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    if (email == "admin" && password == "123456") {
      return UserModel(token: "fake_token_123");
    } else {
      throw Exception("Invalid credentials");
    }
  }

  @override
  Future<UserModel> register(
      String name,
      String email,
      String password,
      ) async {
    await Future.delayed(const Duration(seconds: 3));

    return UserModel(token: "new_user_token_456");
  }

  @override
  Future<UserModel> verifyOtp(String phone, String code) async {
    await Future.delayed(const Duration(seconds: 2));

    if (code == "1234") {
      return UserModel(token: "otp_token_789");
    } else {
      throw Exception("Invalid code");
    }
  }

  @override
  Future<void> resendOtp(String phone) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> sendResetCode(String phoneMail) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<void> resetPassword(String password) async {
    await Future.delayed(const Duration(seconds: 3));
  }
}