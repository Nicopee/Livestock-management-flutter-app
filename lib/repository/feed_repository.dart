import 'package:livestockapp/constants/constants.dart';
import 'package:livestockapp/models/feed.dart';
import 'package:dio_http/dio_http.dart';
import '../middleware/network_interceptor.dart';

class FeedRepository {
  static Future<List<Feed>> getFeeds(int page, int perPage) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: baseURL,
        method: 'GET',
        connectTimeout: timeOut,
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);

    try {
      final response = await dio.request('/feeds',
          queryParameters: {'page': page, 'per_page': perPage});

      List<Feed> feeds = [];
      for (Map feed in response.data['data']) {
        feeds.add(Feed.fromJson(feed));
      }
      return feeds;
    } catch (_) {
      rethrow;
    }
  }

  static Future<Map> addFeed(
    String name,
    String description,
  ) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: baseURL,
        connectTimeout: timeOut,
        method: 'POST',
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);
    dio.interceptors.add(NetworkInterceptor(dio));

    try {
      final response = await dio
          .request('/feeds', data: {'name': name, 'description': description});
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
