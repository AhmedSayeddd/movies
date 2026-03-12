import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/profile/models/user_model.dart';
import 'package:movies/home/models/movie_model.dart';

class ProfileRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> getUserData() async {
    final user = _auth.currentUser;
    if (user == null || user.uid.isEmpty) return null;

    final doc = await _firestore.collection('users').doc(user.uid).get();
    if (doc.exists) {
      final data = doc.data()!;
      // Handle legacy avatarIndex if present
      if (data['avatarPath'] == null && data['avatarIndex'] != null) {
        data['avatarPath'] = 'assets/images/gamer${data['avatarIndex'] + 1}.png';
      }
      // Ensure uid is present in data
      if (data['uid'] == null || data['uid'].toString().isEmpty) {
        data['uid'] = user.uid;
      }
      return UserModel.fromJson(data);
    } else {
      // Create initial user data if it doesn't exist
      final initialUser = UserModel(
        uid: user.uid,
        name: user.displayName ?? 'New User',
        phone: user.phoneNumber ?? '',
        avatarPath: 'assets/images/gamer9.png',
      );
      await updateUserData(initialUser);
      return initialUser;
    }
  }

  Future<void> updateUserData(UserModel user) async {
    if (user.uid.isEmpty) {
      final currentUser = _auth.currentUser;
      if (currentUser == null || currentUser.uid.isEmpty) {
        throw Exception('User is not authenticated or UID is missing');
      }
      // If user.uid is empty but currentUser exists, fix it
      await _firestore.collection('users').doc(currentUser.uid).set(user.toJson()..['uid'] = currentUser.uid);
    } else {
      await _firestore.collection('users').doc(user.uid).set(user.toJson());
    }
  }

  Future<void> toggleWatchlist(MovieModel movie) async {
    final user = await getUserData();
    if (user == null) return;

    List<MovieModel> updatedWatchlist = List.from(user.watchlist);
    final index = updatedWatchlist.indexWhere((m) => m.id == movie.id);

    if (index >= 0) {
      updatedWatchlist.removeAt(index);
    } else {
      updatedWatchlist.add(movie);
    }

    await updateUserData(user.copyWith(watchlist: updatedWatchlist));
  }

  Future<void> addToHistory(MovieModel movie) async {
    final user = await getUserData();
    if (user == null) return;

    List<MovieModel> updatedHistory = List.from(user.history);
    // Remove if already exists to move to top
    updatedHistory.removeWhere((m) => m.id == movie.id);
    updatedHistory.insert(0, movie);

    // Limit history to 20 items
    if (updatedHistory.length > 20) {
      updatedHistory = updatedHistory.sublist(0, 20);
    }

    await updateUserData(user.copyWith(history: updatedHistory));
  }

  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).delete();
      await user.delete();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
