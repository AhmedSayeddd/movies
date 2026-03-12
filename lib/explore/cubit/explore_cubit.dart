import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home/data/repository/movie_repository.dart';
import 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final MovieRepository _repository;

  ExploreCubit(this._repository) : super(ExploreInitial());

  Future<void> fetchMoviesByGenre(String genre) async {
    emit(ExploreLoading());
    try {
      final movies = await _repository.getMovies(genre: genre);
      emit(ExploreLoaded(movies, genre));
    } catch (e) {
      emit(ExploreError(e.toString()));
    }
  }
}
