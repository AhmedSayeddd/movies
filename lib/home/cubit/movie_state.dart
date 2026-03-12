import 'package:equatable/equatable.dart';
import 'package:movies/details/models/movie_details_model.dart';
import '../models/movie_model.dart';

abstract class MovieState extends Equatable {
  const MovieState();
  @override
  List<Object?> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<MovieModel> movies;
  const MovieLoaded(this.movies);
  @override
  List<Object?> get props => [movies];
}

class MovieOffline extends MovieState {
  final List<MovieModel> cachedMovies;
  const MovieOffline(this.cachedMovies);
  @override
  List<Object?> get props => [cachedMovies];
}

class MovieError extends MovieState {
  final String message;
  const MovieError(this.message);
  @override
  List<Object?> get props => [message];
}

class MovieDetailsLoading extends MovieState {}

class MovieDetailsLoaded extends MovieState {
  final MovieDetailsModel movieDetails;
  const MovieDetailsLoaded(this.movieDetails);
  @override
  List<Object?> get props => [movieDetails];
}

class MovieDetailsError extends MovieState {
  final String message;
  const MovieDetailsError(this.message);
  @override
  List<Object?> get props => [message];
}

class SimilarMoviesLoaded extends MovieState {
  final List<MovieModel> similarMovies;
  const SimilarMoviesLoaded(this.similarMovies);
  @override
  List<Object?> get props => [similarMovies];
}
