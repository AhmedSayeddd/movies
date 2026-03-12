import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import 'movie_card.dart';

/// A horizontally scrollable PageView carousel showing featured movies.
/// The center card is bigger and triggers [onMovieChanged] each time a new
/// movie comes into focus so the home screen can animate the background.
class MovieCarousel extends StatefulWidget {
  final List<MovieModel> movies;
  final void Function(int index) onMovieChanged;
  final void Function(MovieModel movie)? onMovieTap;

  const MovieCarousel({
    super.key,
    required this.movies,
    required this.onMovieChanged,
    this.onMovieTap,
  });

  @override
  State<MovieCarousel> createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
  late final PageController _controller;
  double _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      viewportFraction: 0.56,
      initialPage: 1,
    );
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (!mounted) return;
    final page = _controller.page ?? 1;
    setState(() => _currentPage = page);

    // Notify parent when a new whole page comes into view
    final snapped = page.round();
    if ((page - snapped).abs() < 0.03) {
      widget.onMovieChanged(snapped);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.movies.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final movie = widget.movies[index];
          final diff = (index - _currentPage).abs();
          final scale = (1 - (diff * 0.18)).clamp(0.82, 1.0);
          final isCenter = diff < 0.5;

          return GestureDetector(
            onTap: () => widget.onMovieTap?.call(movie),
            child: Transform.translate(
              offset: Offset(
                index < _currentPage ? -(diff * 16) : (diff * 16),
                isCenter ? 10 : 36,
              ),
              child: Transform.scale(
                scale: scale,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isCenter ? 1.0 : 0.86,
                  child: MovieCard(
                    movie: movie,
                    scale: scale,
                    isCenter: isCenter,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
