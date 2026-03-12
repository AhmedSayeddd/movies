import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/core/app_assets.dart';
import '../models/movie_details_model.dart';

class MovieStatsRow extends StatelessWidget {
  final MovieDetailsModel movie;
  const MovieStatsRow({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatChip(
            image: const AssetImage(AppAssets.favorite),
            iconColor: const Color(0xFFFF4B4B),
            value: movie.likes.toString(),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatChip(
            image: const AssetImage(AppAssets.eye),
            iconColor: const Color(0xFF5BC4FF),
            value: movie.views.toString(),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatChip(
            image: const AssetImage(AppAssets.star),
            iconColor: const Color(0xFFFFBB3B),
            value: movie.ratingText,
          ),
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData? icon;
  final ImageProvider? image;
  final Color iconColor;
  final String value;
  const _StatChip({
    this.icon,
    this.image,
    required this.iconColor,
    required this.value,
  }) : assert(icon != null || image != null);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF252525),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (image != null)
            Image(image: image!, width: 28, height: 25, fit: BoxFit.contain)
          else
            Icon(icon, color: iconColor, size: 16),
          const SizedBox(width: 6),
          Text(
            value,
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
