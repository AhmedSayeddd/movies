import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repository/movie_repository.dart';
import 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieRepository repository;
  MovieCubit(this.repository) : super(MovieInitial());
  Future<void> fetchMovies() async {
    emit(MovieLoading());
    try {
      final movies = await repository.getMovies();
      final isOffline = await repository.isOffline();
      if (isOffline) {
        emit(MovieOffline(movies));
      } else {
        emit(MovieLoaded(movies));
      }
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }
  Future<void> fetchMovieDetails(int id) async {
    emit(MovieDetailsLoading());
    try {
      final details = await repository.getMovieDetails(id);
      if (details != null) {
        final similar = await repository.getSimilarMovies(id);
        final detailsWithSimilar = details.copyWith(similarMovies: similar);
        emit(MovieDetailsLoaded(detailsWithSimilar));
      } else {
        emit(MovieDetailsError("Movie not found"));
      }
    } catch (e) {
      emit(MovieDetailsError(e.toString()));
    }
  }
  Future<void> fetchSimilarMovies(int id) async {
    try {
      final similar = await repository.getSimilarMovies(id);
      emit(SimilarMoviesLoaded(similar));
    } catch (e) {
    }
  }
}
