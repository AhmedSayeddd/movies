import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/widgets/custom_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/home/cubit/movie_cubit.dart';
import 'package:movies/home/cubit/movie_state.dart';
import 'package:movies/home/models/movie_model.dart';
import 'widgets/category_section.dart';
import 'widgets/movie_carousel.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _focusedMovieIndex = 1;
  String _currentBg = '';
  String _nextBg = '';
  bool _showNext = false;
  late final AnimationController _bgAnimController;
  late final Animation<double> _bgFadeAnim;

  @override
  void initState() {
    super.initState();
    context.read<MovieCubit>().fetchMovies();
    _bgAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _bgFadeAnim = CurvedAnimation(
      parent: _bgAnimController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _bgAnimController.dispose();
    super.dispose();
  }

  void _onMovieChanged(int index, List<MovieModel> featured) {
    if (index == _focusedMovieIndex) return;
    if (index >= 0 && index < featured.length) {
      final newPoster = featured[index].poster;
      setState(() {
        _focusedMovieIndex = index;
        _nextBg = newPoster;
        _showNext = true;
      });
      _bgAnimController.forward(from: 0).then((_) {
        setState(() {
          _currentBg = newPoster;
          _showNext = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        if (state is MovieLoading || state is MovieInitial) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFFFFBB3B)),
            ),
          );
        } else if (state is MovieError) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }
        List<MovieModel> movies = [];
        bool isOffline = false;
        if (state is MovieLoaded) {
          movies = state.movies;
        } else if (state is MovieOffline) {
          movies = state.cachedMovies;
          isOffline = true;
        }
        if (movies.isEmpty) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Text("No movies found", style: TextStyle(color: Colors.white)),
            ),
          );
        }
        final featured = movies.take(8).toList();
        final action = movies.skip(8).toList();
        if (action.isEmpty) action.addAll(featured);
        if (_currentBg.isEmpty && featured.length > 1) {
          _currentBg = featured[1].poster;
          _nextBg = _currentBg;
        }
        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              _AnimatedBackground(
                currentBg: _currentBg,
                nextBg: _nextBg,
                fadeAnim: _bgFadeAnim,
                showNext: _showNext,
              ),
              SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 108),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isOffline)
                        Container(
                          width: double.infinity,
                          color: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: const Text(
                            "Offline Mode - Viewing Cached Data",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      const SizedBox(height: 6),
                      Center(
                        child: Image.asset(
                          'assets/images/Available Now.png',
                          height: 80,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 6),
                      MovieCarousel(
                        movies: featured,
                        onMovieChanged: (index) => _onMovieChanged(index, featured),
                        onMovieTap: (movie) => Navigator.pushNamed(
                          context,
                          '/movieDetails',
                          arguments: movie,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Center(
                        child: Image.asset(
                          'assets/images/Watch Now.png',
                          height: 78,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 16),
                      CategorySection(
                        title: 'Action',
                        movies: action,
                        onSeeMore: () {},
                        onMovieTap: (movie) => Navigator.pushNamed(
                          context,
                          '/movieDetails',
                          arguments: movie,
                        ),
                      ),
                      const SizedBox(height: 22),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AnimatedBackground extends StatelessWidget {
  final String currentBg;
  final String nextBg;
  final Animation<double> fadeAnim;
  final bool showNext;
  const _AnimatedBackground({
    required this.currentBg,
    required this.nextBg,
    required this.fadeAnim,
    required this.showNext,
  });
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomImage(
            imagePath: currentBg,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
          if (showNext)
            AnimatedBuilder(
              animation: fadeAnim,
              builder: (_, __) => Opacity(
                opacity: fadeAnim.value,
                child: CustomImage(
                  imagePath: nextBg,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
            child: const SizedBox.expand(),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.20),
                  Colors.black.withOpacity(0.06),
                  Colors.black.withOpacity(0.18),
                  Colors.black.withOpacity(0.70),
                  Colors.black.withOpacity(0.92),
                ],
                stops: const [0.0, 0.18, 0.44, 0.76, 1.0],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
