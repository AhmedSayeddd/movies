import 'package:movies/home/models/movie_model.dart';
import 'package:equatable/equatable.dart';

class CastModel extends Equatable {
  final String name;
  final String character;
  final String avatar;

  const CastModel({
    required this.name,
    required this.character,
    required this.avatar,
  });

  @override
  List<Object?> get props => [name, character, avatar];

  factory CastModel.fromJson(Map<String, dynamic> json) => CastModel(
        name: json['name']?.toString() ?? json['actor_name']?.toString() ?? '',
        character: json['character_name']?.toString() ?? json['character']?.toString() ?? '',
        avatar: json['url_small_image']?.toString() ?? json['url_avatar']?.toString() ?? json['avatar']?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'character_name': character,
        'url_small_image': avatar,
      };
}

class MovieDetailsModel extends Equatable {
  final int id;
  final String title;
  final String poster;
  final int year;
  final double rating;
  final int likes;
  final int views;
  final int runtime;
  final String summary;
  final List<String> screenshots;
  final List<String> genres;
  final List<CastModel> cast;
  final List<MovieModel> similarMovies;

  const MovieDetailsModel({
    required this.id,
    required this.title,
    required this.poster,
    required this.year,
    required this.rating,
    required this.likes,
    required this.views,
    required this.runtime,
    required this.summary,
    required this.screenshots,
    required this.genres,
    required this.cast,
    required this.similarMovies,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        poster,
        year,
        rating,
        likes,
        views,
        runtime,
        summary,
        screenshots,
        genres,
        cast,
        similarMovies,
      ];

  String get ratingText => rating.toStringAsFixed(1);

  String get runtimeText {
    if (runtime <= 0) return 'N/A';
    final hours = runtime ~/ 60;
    final minutes = runtime % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }

  MovieDetailsModel copyWith({
    int? id,
    String? title,
    String? poster,
    int? year,
    double? rating,
    int? likes,
    int? views,
    int? runtime,
    String? summary,
    List<String>? screenshots,
    List<String>? genres,
    List<CastModel>? cast,
    List<MovieModel>? similarMovies,
  }) {
    return MovieDetailsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      poster: poster ?? this.poster,
      year: year ?? this.year,
      rating: rating ?? this.rating,
      likes: likes ?? this.likes,
      views: views ?? this.views,
      runtime: runtime ?? this.runtime,
      summary: summary ?? this.summary,
      screenshots: screenshots ?? this.screenshots,
      genres: genres ?? this.genres,
      cast: cast ?? this.cast,
      similarMovies: similarMovies ?? this.similarMovies,
    );
  }

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    List<String> parsedScreenshots = [];
    if (json['medium_screenshot_image1'] != null) parsedScreenshots.add(json['medium_screenshot_image1'].toString());
    if (json['medium_screenshot_image2'] != null) parsedScreenshots.add(json['medium_screenshot_image2'].toString());
    if (json['medium_screenshot_image3'] != null) parsedScreenshots.add(json['medium_screenshot_image3'].toString());
    
    if (json['large_screenshot_image1'] != null) parsedScreenshots.add(json['large_screenshot_image1'].toString());
    if (json['large_screenshot_image2'] != null) parsedScreenshots.add(json['large_screenshot_image2'].toString());
    if (json['large_screenshot_image3'] != null) parsedScreenshots.add(json['large_screenshot_image3'].toString());

    if (parsedScreenshots.isEmpty) {
      if (json['screenshots'] != null && json['screenshots'] is List) {
        parsedScreenshots = (json['screenshots'] as List).map((e) => e.toString()).toList();
      }
    }

    parsedScreenshots = parsedScreenshots.where((s) => s.isNotEmpty && s != 'null').toList();
    parsedScreenshots = parsedScreenshots.toSet().toList();

    var castList = json['cast'];
    if (castList == null) castList = json['actor'];
    if (castList == null) castList = json['actors'];

    return MovieDetailsModel(
      id: json['id'] is int ? json['id'] as int : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      title: json['title']?.toString() ?? '',
      poster: json['large_cover_image']?.toString() ?? json['background_image']?.toString() ?? json['poster']?.toString() ?? '',
      year: json['year'] is int ? json['year'] as int : int.tryParse(json['year']?.toString() ?? '0') ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      likes: (json['like_count'] as num?)?.toInt() ?? (json['likes'] as num?)?.toInt() ?? 0,
      views: (json['download_count'] as num?)?.toInt() ?? (json['views'] as num?)?.toInt() ?? 0,
      runtime: (json['runtime'] as num?)?.toInt() ?? 0,
      summary: json['description_full']?.toString() ?? json['summary']?.toString() ?? '',
      screenshots: parsedScreenshots,
      genres: (json['genres'] as List<dynamic>? ?? []).map((e) => e.toString()).toList(),
      cast: (castList as List<dynamic>? ?? [])
          .map((e) => CastModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      similarMovies: (json['similarMovies'] as List<dynamic>? ?? [])
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'large_cover_image': poster,
        'year': year,
        'rating': rating,
        'like_count': likes,
        'download_count': views,
        'runtime': runtime,
        'description_full': summary,
        'screenshots': screenshots,
        'genres': genres,
        'cast': cast.map((e) => e.toJson()).toList(),
        'similarMovies': similarMovies.map((e) => e.toJson()).toList(),
      };
}
