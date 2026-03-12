import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:movies/home/data/datasource/movie_local_data_source.dart';
import 'package:movies/home/data/datasource/movie_remote_data_source.dart';
import 'package:movies/home/models/movie_model.dart';
import 'package:movies/details/models/movie_details_model.dart';

class MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  MovieRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  Future<List<MovieModel>> getMovies({String? genre}) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      try {
        final movies = await remoteDataSource.fetchMovies(genre: genre);
        if (genre == null) {
          await localDataSource.saveMovies(movies);
        }
        return movies;
      } catch (e) {
        return genre == null ? await localDataSource.getCachedMovies() : [];
      }
    } else {
      return genre == null ? await localDataSource.getCachedMovies() : [];
    }
  }
  Future<MovieDetailsModel?> getMovieDetails(int id) async {
    return await remoteDataSource.fetchMovieDetails(id);
  }
  Future<List<MovieModel>> getSimilarMovies(int id) async {
    return await remoteDataSource.fetchSimilarMovies(id);
  }
  Future<bool> isOffline() async {
    final result = await Connectivity().checkConnectivity();
    return result == ConnectivityResult.none;
  }
}
