import 'package:movies/core/cache/cache_helper.dart';
import 'package:movies/home/models/movie_model.dart';

class MovieLocalDataSource {
  Future<void> saveMovies(List<MovieModel> movies) async {
    await CacheHelper.cacheMovies(movies);
  }
  Future<List<MovieModel>> getCachedMovies() async {
    return await CacheHelper.getCachedMovies();
  }
}
