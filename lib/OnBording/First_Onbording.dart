import 'package:flutter/material.dart';
import '../core/app_assets.dart';
import '../core/app_color.dart';
import '../core/app_style.dart';

class MovieOnboardingScreen extends StatelessWidget {
  const MovieOnboardingScreen({super.key});
  static const String routeName = 'MovieOnboardingScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppColor.black),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppAssets.MoviesPosters, fit: BoxFit.cover),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Find Your Next\nFavorite Movie Here",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Get access to a huge library of movies\nto suit all tastes. You will surely like it.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'OnboardingScreen');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(AppColor.gold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "Explore Now",
                        style: AppStyle.subtitletext.copyWith(
                         fontWeight: FontWeight.w600, color: Colors.black)),
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