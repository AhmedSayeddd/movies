import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../../core/widgets/custom_image.dart';
import 'rating_badge.dart';

/// A smaller poster card used in the category horizontal list.
class CategoryMovieCard extends StatelessWidget {
  final MovieModel movie;
  final VoidCallback? onTap;

  const CategoryMovieCard({
    super.key,
    required this.movie,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        height: 164,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Poster image
            Positioned.fill(
              child: CustomImage(
                imagePath: movie.poster,
                fit: BoxFit.cover,
              ),
            ),
            // Gradient overlay at bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.86),
                    ],
                  ),
                ),
              ),
            ),
            // Rating badge
            Positioned(
              top: 8,
              left: 8,
              child: RatingBadge(rating: movie.ratingText),
            ),
          ],
        ),
      ),
    );
  }
}
