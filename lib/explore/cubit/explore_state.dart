import 'package:equatable/equatable.dart';
import '../../home/models/movie_model.dart';

abstract class ExploreState extends Equatable {
  const ExploreState();

  @override
  List<Object?> get props => [];
}

class ExploreInitial extends ExploreState {}

class ExploreLoading extends ExploreState {}

class ExploreLoaded extends ExploreState {
  final List<MovieModel> movies;
  final String selectedGenre;

  const ExploreLoaded(this.movies, this.selectedGenre);

  @override
  List<Object?> get props => [movies, selectedGenre];
}

class ExploreError extends ExploreState {
  final String message;

  const ExploreError(this.message);

  @override
  List<Object?> get props => [message];
}
