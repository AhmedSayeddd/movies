import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/movie_model.dart';
import 'category_movie_card.dart';

/// Action / category section with a "See More →" header and a horizontal card list.
class CategorySection extends StatelessWidget {
  final String title;
  final List<MovieModel> movies;
  final VoidCallback? onSeeMore;
  final void Function(MovieModel movie)? onMovieTap;

  const CategorySection({
    super.key,
    required this.title,
    required this.movies,
    this.onSeeMore,
    this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header ──────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: onSeeMore,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: Row(
                    children: [
                      Text(
                        'See More',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFFFBB3B),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color(0xFFFFBB3B),
                        size: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // ── Horizontal movie list ─────────────────────────────
        SizedBox(
          height: 172,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: movies.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return CategoryMovieCard(
                movie: movies[index],
                onMovieTap: (movie) => onMovieTap?.call(movie),
              );
            },
          ),
        ),
      ],
    );
  }
}
