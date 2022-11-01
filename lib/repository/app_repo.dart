import 'dart:io';

import 'package:dio_http/dio_http.dart';

import '../constants/constants.dart';
import '../models/version.dart';

class AppRepo {
  static Future<Version> checkForUpdate() async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: baseURL,
        connectTimeout: timeOut,
        method: 'GET',
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);

    try {
      var response = await dio.request('/latest', queryParameters: {
        'platform': Platform.isAndroid ? 'android' : 'ios',
        'type': 'customer'
      });

      return Version.fromJson(response.data);
    } catch (_) {
      rethrow;
    }
  }
}
