import 'package:dio/dio.dart';

class DioHelper {
  /// api key and country
  static const Map<String, dynamic> _authParameters = {
    'apiKey': 'c6ce814bfa4342e6bd0b838aebcf1114',
    'country': 'eg'
  };

  /// Internal [Dio] Instance with Specified [BaseOptions]
  final Dio _dio = Dio(BaseOptions(
      baseUrl: 'https://newsapi.org/',
      receiveDataWhenStatusError: true,
      queryParameters: _authParameters));

  /// Takes a [path] and [category] of news then returns a [Future]<[Response]> of
  /// the data it gets.
  /// if [category] is null it will get all type of news
  Future<Response<Map>> getDataForCategory(
      {String path = 'v2/top-headlines',
      String? category,
      String country = 'eg',
      Map<String, dynamic>? queryParam}) async {
    /// adding category to map to use it in query parameters
    if (queryParam == null && category != null) {
      queryParam = {'category': category};
    } else if (queryParam != null && category == null) {
      queryParam.addAll({'country': country});
    } else if (queryParam != null && category != null) {
      queryParam.addAll({'category': category, 'country': country});
    } else if (queryParam == null && category == null) {
      queryParam = {'country': country};
    }
    return await _dio.get(path, queryParameters: queryParam);
  }
}
