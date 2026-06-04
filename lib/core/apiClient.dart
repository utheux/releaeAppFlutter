import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class ApiClient {
  static final CookieJar cookieJar = CookieJar();

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:3333',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ),
  )..interceptors.add(CookieManager(cookieJar));

  static Future<void> clearCookies() {
    return cookieJar.deleteAll();
  }
}
