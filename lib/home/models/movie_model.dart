import 'package:equatable/equatable.dart';

class MovieModel extends Equatable {
  final int id;
  final String title;
  final String poster;
  final double rating;
  final int year;
  final List<String> genres;
  final String summary;
  const MovieModel({
    required this.id,
    required this.title,
    required this.poster,
    required this.rating,
    required this.year,
    required this.genres,
    required this.summary,
  });
  @override
  List<Object?> get props => [id, title, poster, rating, year, genres, summary];
  String get ratingText => rating.toStringAsFixed(1);
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] is int ? json['id'] as int : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      title: json['title']?.toString() ?? '',
      poster: json['large_cover_image']?.toString() ?? json['medium_cover_image']?.toString() ?? json['poster']?.toString() ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      year: json['year'] is int ? json['year'] as int : int.tryParse(json['year']?.toString() ?? '0') ?? 0,
      genres: (json['genres'] as List<dynamic>? ?? []).map((e) => e.toString()).toList(),
      summary: json['summary']?.toString() ?? json['description_full']?.toString() ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'poster': poster,
        'rating': rating,
        'year': year,
        'genres': genres,
        'summary': summary,
      };
}
