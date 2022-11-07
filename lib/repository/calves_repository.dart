import 'package:livestockapp/constants/constants.dart';
import 'package:livestockapp/models/calf.dart';
import 'package:dio_http/dio_http.dart';
import '../middleware/network_interceptor.dart';

class CalvesRepository {
  static Future<List<Calf>> getCalves(int page, int perPage) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: baseURL,
        method: 'GET',
        connectTimeout: timeOut,
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);

    try {
      final response = await dio.request('calfs',
          queryParameters: {'page': page, 'per_page': perPage});

      List<Calf> calves = [];
      for (Map feed in response.data['data']) {
        calves.add(Calf.fromJson(feed));
      }
      return calves;
    } catch (_) {
      rethrow;
    }
  }
}
