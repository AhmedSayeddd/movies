import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A Wrap of rounded genre pill chips.
class GenresWrap extends StatelessWidget {
  final List<String> genres;

  const GenresWrap({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: genres.map((genre) => _GenreChip(label: genre)).toList(),
    );
  }
}

class _GenreChip extends StatelessWidget {
  final String label;

  const _GenreChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.roboto(
          color: Colors.white.withValues(alpha: 0.88),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
