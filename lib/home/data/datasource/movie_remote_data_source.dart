import 'package:movies/core/network/api_service.dart';
import 'package:movies/details/models/movie_details_model.dart';
import 'package:movies/home/models/movie_model.dart';

class MovieRemoteDataSource {
  final ApiService apiService;
  MovieRemoteDataSource(this.apiService);
  Future<List<MovieModel>> fetchMovies({String? genre}) async {
    final response = await apiService.getMovies(genre: genre);
    final List data = response['data']['movies'] ?? [];
    return data.map((m) => MovieModel.fromJson(m)).toList();
  }

  Future<MovieDetailsModel?> fetchMovieDetails(int id) async {
    final response = await apiService.getMovieDetails(id);
    final data = response['data']['movie'];
    if (data != null) {
      return MovieDetailsModel.fromJson(data);
    }
    return null;
  }

  Future<List<MovieModel>> fetchSimilarMovies(int id) async {
    final response = await apiService.getSimilarMovies(id);
    final List data = response['data']['movies'] ?? [];
    return data.map((m) => MovieModel.fromJson(m)).toList();
  }
}
