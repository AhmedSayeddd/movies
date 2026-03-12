import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/profile/data/profile_repository.dart';
import 'package:movies/home/models/movie_model.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;
  ProfileCubit(this.repository) : super(ProfileInitial());

  Future<void> loadProfile() async {
    emit(ProfileLoading());
    try {
      final user = await repository.getUserData();
      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError('User not found'));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateProfile({String? name, String? phone, String? avatarPath}) async {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      final updatedUser = currentState.user.copyWith(
        name: name,
        phone: phone,
        avatarPath: avatarPath,
      );
      emit(ProfileUpdating(updatedUser));
      try {
        await repository.updateUserData(updatedUser);
        emit(ProfileLoaded(updatedUser));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    }
  }

  Future<void> addToHistory(MovieModel movie) async {
    try {
      await repository.addToHistory(movie);
      await loadProfile();
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> toggleWatchlist(MovieModel movie) async {
    try {
      await repository.toggleWatchlist(movie);
      await loadProfile();
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> deleteAccount() async {
    try {
      await repository.deleteAccount();
      emit(ProfileInitial());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> logout() async {
    await repository.logout();
    emit(ProfileInitial());
  }
}
