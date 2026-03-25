import 'package:dio/dio.dart';

class DioFactory {
  static Dio create() {
    return Dio(
      BaseOptions(
        baseUrl: "https://fake-api.com/",
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
      ),
    );
  }
}