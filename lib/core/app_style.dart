import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/core/app_color.dart';

class AppStyle {
  static final TextStyle titletext = GoogleFonts.inter(
    fontSize: 36,
    fontWeight: FontWeight.w500,
    color: const Color(AppColor.white),
  );

  static final TextStyle subtitletext = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: const Color(AppColor.white),
  );

  static final TextStyle summarytext = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: const Color(AppColor.white),
  );

  static final TextStyle tex = GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: const Color(AppColor.white),
  );
}
