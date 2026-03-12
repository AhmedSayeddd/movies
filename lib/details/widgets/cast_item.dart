import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/movie_details_model.dart';
import '../../../core/widgets/custom_image.dart';

class CastItem extends StatelessWidget {
  final CastModel member;
  const CastItem({super.key, required this.member});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF232323),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF333333),
            ),
            child: CustomImage(
              imagePath: member.avatar,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.6,
                ),
                children: [
                  TextSpan(
                    text: 'Name: ',
                    style: GoogleFonts.roboto(
                      color: Colors.white.withValues(alpha: 0.55),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: '${member.name}\n',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: 'Character: ',
                    style: GoogleFonts.roboto(
                      color: Colors.white.withValues(alpha: 0.55),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: member.character,
                    style: GoogleFonts.roboto(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
