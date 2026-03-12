import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/home/models/movie_model.dart';
import 'package:movies/home/widgets/rating_badge.dart';
import '../../../core/widgets/custom_image.dart';

class SimilarMoviesSection extends StatelessWidget {
  final List<MovieModel> movies;
  final Function(MovieModel) onMovieTap;
  const SimilarMoviesSection({
    super.key,
    required this.movies,
    required this.onMovieTap,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Similar',
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.72,
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return GestureDetector(
              onTap: () => onMovieTap(movie),
              child: _SimilarCard(movie: movie),
            );
          },
        ),
      ],
    );
  }
}

class _SimilarCard extends StatelessWidget {
  final MovieModel movie;
  const _SimilarCard({required this.movie});
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: CustomImage(
              imagePath: movie.poster,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: RatingBadge(rating: movie.ratingText),
          ),
        ],
      ),
    );
  }
}
