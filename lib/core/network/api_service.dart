import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;
  static const String _baseUrl = 'https://yts.lt/api/v2/';
  ApiService()
      : _dio = Dio(BaseOptions(
          baseUrl: _baseUrl,
          receiveTimeout: const Duration(seconds: 15),
          connectTimeout: const Duration(seconds: 15),
        ));
  Future<Map<String, dynamic>> getMovies({int limit = 20, int page = 1, String? genre}) async {
    final Map<String, dynamic> queryParameters = {
      'limit': limit,
      'page': page,
    };
    if (genre != null && genre.isNotEmpty) {
      queryParameters['genre'] = genre;
    }
    final response = await _dio.get('list_movies.json', queryParameters: queryParameters);
    return response.data;
  }
  Future<Map<String, dynamic>> getMovieDetails(int id) async {
    final response = await _dio.get('movie_details.json', queryParameters: {
      'movie_id': id,
      'with_images': 'true',
      'with_cast': 'true',
    });
    return response.data;
  }
  Future<Map<String, dynamic>> getSimilarMovies(int id) async {
    final response = await _dio.get('movie_suggestions.json', queryParameters: {
      'movie_id': id,
    });
    return response.data;
  }
}
