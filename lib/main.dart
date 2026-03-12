import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/cache/cache_helper.dart';
import 'package:movies/core/network/api_service.dart';
import 'package:movies/details/movie_details_screen.dart';
import 'package:movies/explore/cubit/explore_cubit.dart';
import 'package:movies/home/cubit/movie_cubit.dart';
import 'package:movies/home/data/datasource/movie_local_data_source.dart';
import 'package:movies/home/data/datasource/movie_remote_data_source.dart';
import 'package:movies/home/data/repository/movie_repository.dart';
import 'package:movies/home/home_screen.dart';
import 'package:movies/main_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  final movieRepository = MovieRepository(
    remoteDataSource: MovieRemoteDataSource(ApiService()),
    localDataSource: MovieLocalDataSource(),
  );
  runApp(MoviesApp(movieRepository: movieRepository));
}

class MoviesApp extends StatelessWidget {
  final MovieRepository movieRepository;
  const MoviesApp({super.key, required this.movieRepository});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider.value(value: movieRepository)],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => MovieCubit(movieRepository)),
          BlocProvider(create: (context) => ExploreCubit(movieRepository)),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Movies App',
          theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF141414),
            useMaterial3: true,
          ),
          initialRoute: MainWrapper.routeName,
          routes: {
            MainWrapper.routeName: (context) => const MainWrapper(),
            HomeScreen.routeName: (context) => const HomeScreen(),
            MovieDetailsScreen.routeName: (context) =>
                const MovieDetailsScreen(),
          },
        ),
      ),
    );
  }
}
