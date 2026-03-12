import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/cache/cache_helper.dart';
import 'package:movies/core/network/api_service.dart';
import 'package:movies/details/movie_details_screen.dart';
import 'package:movies/home/cubit/movie_cubit.dart';
import 'package:movies/home/data/datasource/movie_local_data_source.dart';
import 'package:movies/home/data/datasource/movie_remote_data_source.dart';
import 'package:movies/home/data/repository/movie_repository.dart';
import 'package:movies/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => MovieRepository(
        remoteDataSource: MovieRemoteDataSource(ApiService()),
        localDataSource: MovieLocalDataSource(),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies App',
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF141414),
          useMaterial3: true,
        ),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => BlocProvider(
                create: (context) => MovieCubit(context.read<MovieRepository>())..fetchMovies(),
                child: const HomeScreen(),
              ),
          MovieDetailsScreen.routeName: (context) => BlocProvider(
                create: (context) => MovieCubit(context.read<MovieRepository>()),
                child: const MovieDetailsScreen(),
              ),
        },
      ),
    );
  }
}
