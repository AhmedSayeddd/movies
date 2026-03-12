import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies/home/models/movie_model.dart';

class CacheHelper {
  static const String movieBox = 'movie_box';
  static Future<void> init() async {
    await Hive.initFlutter();
  }
  static Future<void> cacheMovies(List<MovieModel> movies) async {
    var box = await Hive.openBox(movieBox);
    final data = movies.map((m) => m.toJson()).toList();
    await box.put('movies', data);
  }
  static Future<List<MovieModel>> getCachedMovies() async {
    var box = await Hive.openBox(movieBox);
    final List? data = box.get('movies');
    if (data != null) {
      return data.map((m) => MovieModel.fromJson(Map<String, dynamic>.from(m))).toList();
    }
    return [];
  }
  static Future<void> clearCache() async {
    var box = await Hive.openBox(movieBox);
    await box.clear();
  }
}
