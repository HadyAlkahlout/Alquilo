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
}