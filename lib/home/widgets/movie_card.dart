import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../../core/widgets/custom_image.dart';
import 'rating_badge.dart';

/// A single movie poster card used inside the featured [MovieCarousel].
/// Shows the poster image, a rating badge, a tagline for the center card,
/// and scales based on [scale] to create the 3D carousel feel.
class MovieCard extends StatelessWidget {
  final MovieModel movie;
  final double scale;
  final bool isCenter;

  const MovieCard({
    super.key,
    required this.movie,
    required this.scale,
    required this.isCenter,
  });

  @override
  Widget build(BuildContext context) {
    final double width = isCenter ? 186.0 : 108.0;
    final double height = isCenter ? 256.0 : 178.0;
    final double radius = isCenter ? 26.0 : 20.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isCenter ? 0.55 : 0.32),
            blurRadius: isCenter ? 28 : 14,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Poster
          Positioned.fill(
            child: CustomImage(
              imagePath: movie.poster,
              fit: BoxFit.cover,
            ),
          ),
          // Dark overlay for readability
          if (!isCenter)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(radius),
                ),
              ),
            ),
          // Rating badge
          Positioned(
            top: 10,
            left: 10,
            child: RatingBadge(rating: movie.ratingText),
          ),
          // Tagline at bottom (center card only)
          if (isCenter && movie.summary.isNotEmpty)
            Positioned(
              left: 0,
              right: 0,
              bottom: 14,
              child: Center(
                child: Text(
                  movie.summary,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 7.5,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 3,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
