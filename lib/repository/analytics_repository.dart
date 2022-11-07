import 'package:livestockapp/constants/constants.dart';
import 'package:livestockapp/models/analytics.dart';
import 'package:dio_http/dio_http.dart';

class AnalyticsRepository {
  static Future<Analytics> getAnalytics() async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: baseURL,
        connectTimeout: timeOut,
        method: 'GET',
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);

    try {
      var response = await dio.request('incomes/sum');

      return Analytics.fromJson(response.data);
    } catch (_) {
      rethrow;
    }
  }
}
