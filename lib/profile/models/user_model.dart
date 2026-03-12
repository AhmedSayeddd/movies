import 'package:movies/home/models/movie_model.dart';

class UserModel {
  final String uid;
  final String name;
  final String phone;
  final String avatarPath;
  final List<MovieModel> watchlist;
  final List<MovieModel> history;

  UserModel({
    required this.uid,
    required this.name,
    required this.phone,
    required this.avatarPath,
    this.watchlist = const [],
    this.history = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      avatarPath: json['avatarPath'] ?? 'assets/images/gamer9.png',
      watchlist: (json['watchlist'] as List?)
              ?.map((m) => MovieModel.fromJson(m as Map<String, dynamic>))
              .toList() ??
          [],
      history: (json['history'] as List?)
              ?.map((m) => MovieModel.fromJson(m as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'phone': phone,
      'avatarPath': avatarPath,
      'watchlist': watchlist.map((m) => m.toJson()).toList(),
      'history': history.map((m) => m.toJson()).toList(),
    };
  }

  UserModel copyWith({
    String? name,
    String? phone,
    String? avatarPath,
    List<MovieModel>? watchlist,
    List<MovieModel>? history,
  }) {
    return UserModel(
      uid: uid,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      avatarPath: avatarPath ?? this.avatarPath,
      watchlist: watchlist ?? this.watchlist,
      history: history ?? this.history,
    );
  }
}
