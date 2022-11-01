import 'package:livestockapp/constants/constants.dart';
import 'package:livestockapp/models/access_token.dart';
import 'package:livestockapp/models/user.dart';
import 'package:dio_http/dio_http.dart';

import '../middleware/network_interceptor.dart';

class UserRepository {
  static Future<Map> login(
    String email,
    String password,
  ) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: baseURL,
        connectTimeout: timeOut,
        method: 'POST',
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);

    try {
      final response = await dio.request('/client/login',
          data: {'username': email, 'password': password});
      var results = {
        'user': User.fromJson(response.data['user']),
        'access_token': AccessToken.fromJson(response.data['token'])
      };
      return results;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> updateAccount(int userId, Map user) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: baseURL,
        connectTimeout: timeOut,
        method: 'PUT',
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);
    dio.interceptors.add(NetworkInterceptor(dio));

    try {
      await dio.request('/customers/$userId', data: user);
    } catch (_) {
      rethrow;
    }
  }

  static Future<void> sendFeedBack(String message) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: baseURL,
        connectTimeout: timeOut,
        method: 'POST',
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);
    dio.interceptors.add(NetworkInterceptor(dio));

    try {
      await dio.request('/feedback', data: {'feedback': message});
    } catch (_) {
      rethrow;
    }
  }

  static Future<void> changePassword(
      String oldPassword, String newPassword) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: baseURL,
        connectTimeout: timeOut,
        method: 'PUT',
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);
    dio.interceptors.add(NetworkInterceptor(dio));

    try {
      await dio.request('/customer/change-pass',
          data: {'current_password': oldPassword, 'password': newPassword});
    } catch (_) {
      rethrow;
    }
  }

  static Future<void> register(Map user) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: baseURL,
        connectTimeout: timeOut,
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);

    try {
      await dio.post('/customers', data: user);
    } catch (_) {
      rethrow;
    }
  }

  static Future<void> resetPassword(String email) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: baseURL,
        connectTimeout: timeOut,
        method: 'POST',
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);

    try {
      await dio.request('/customer/forgot-password', data: {'email': email});
    } catch (_) {
      rethrow;
    }
  }

  static Future<AccessToken> requestNewToken(String refreshToken) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: baseURL,
        connectTimeout: timeOut,
        method: 'POST',
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);

    try {
      final response = await dio.request('/customers/refresh-token',
          data: {'refresh_token': refreshToken});

      return AccessToken.fromJson(response.data);
    } catch (_) {
      rethrow;
    }
  }
}
