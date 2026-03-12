import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movies/auth/firebase_options.dart';
import 'package:movies/core/cache/cache_helper.dart';
import 'package:movies/core/network/api_service.dart';
import 'package:movies/details/movie_details_screen.dart';
import 'package:movies/explore/cubit/explore_cubit.dart';
import 'package:movies/home/cubit/movie_cubit.dart';
import 'package:movies/home/data/datasource/movie_local_data_source.dart';
import 'package:movies/home/data/datasource/movie_remote_data_source.dart';
import 'package:movies/home/data/repository/movie_repository.dart';
import 'package:movies/home/home_screen.dart';
import 'package:movies/search/cubit/search_cubit.dart';
import 'package:movies/OnBording/First_Onbording.dart';
import 'package:movies/OnBording/onboarding_screen.dart';
import 'package:movies/auth/screens/login_screen.dart';
import 'package:movies/main_wrapper.dart';
import 'package:movies/profile/data/profile_repository.dart';
import 'package:movies/profile/cubit/profile_cubit.dart';
import 'package:movies/splash_screen.dart';
import 'package:movies/auth/screens/register_screen.dart';
import 'package:movies/auth/screens/forgetPassword_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  
  final movieRepository = MovieRepository(
    remoteDataSource: MovieRemoteDataSource(ApiService()),
    localDataSource: MovieLocalDataSource(),
  );
  
  final profileRepository = ProfileRepository();

  runApp(MoviesApp(
    movieRepository: movieRepository,
    profileRepository: profileRepository,
  ));
}

class MoviesApp extends StatelessWidget {
  final MovieRepository movieRepository;
  final ProfileRepository profileRepository;
  
  const MoviesApp({
    super.key, 
    required this.movieRepository,
    required this.profileRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: movieRepository),
        RepositoryProvider.value(value: profileRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => MovieCubit(movieRepository)),
          BlocProvider(create: (context) => ExploreCubit(movieRepository)),
          BlocProvider(create: (context) => SearchCubit(movieRepository)),
          BlocProvider(create: (context) => ProfileCubit(profileRepository)..loadProfile()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Movies App',
          theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF141414),
            useMaterial3: true,
          ),
          initialRoute: SplashScreen.routeName,
          routes: {
            SplashScreen.routeName: (context) => const SplashScreen(),
            MovieOnboardingScreen.routeName: (context) => const MovieOnboardingScreen(),
            OnboardingScreen.routeName: (context) => const OnboardingScreen(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            RegisterScreen.routeName: (context) => const RegisterScreen(),
            ForgetpasswordScreen.routeName: (context) => const ForgetpasswordScreen(),
            MainWrapper.routeName: (context) => const MainWrapper(),
            HomeScreen.routeName: (context) => const HomeScreen(),
            MovieDetailsScreen.routeName: (context) => const MovieDetailsScreen(),
          },
        ),
      ),
    );
  }
}
