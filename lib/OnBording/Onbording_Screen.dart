import 'package:flutter/material.dart';

import '../Model/Onbording_item.dart';
import '../core/app_assets.dart';
import 'Onbording_Card.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = 'OnboardingScreen';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  final List<OnboardingItem> onboardingData = [
    OnboardingItem(
        title: "Discover Movies",
        description: "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
        imagePath: AppAssets.Acengers
    ),
    OnboardingItem(
        title: "Explore All Genres",
        description: "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
        imagePath: AppAssets.OppenHeimer
    ),
    OnboardingItem(
        title: "Create Watchlists",
        description: "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
        imagePath: AppAssets.BadBoys
    ),
    OnboardingItem(
        title: "Rate, Review, and Learn",
        description: "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
        imagePath: AppAssets.Drstrange
    ),
    OnboardingItem(
        title: "Start Watching Now",
        description: "",
        imagePath: AppAssets.poster5
    ),
  ];

  bool get isLastPage => currentIndex == onboardingData.length - 1;
  bool get isFirstPage => currentIndex == 0;

  @override
  Widget build(BuildContext context) {
    final currentItem = onboardingData[currentIndex];

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(currentItem.imagePath, fit: BoxFit.cover),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Onbordingcard(
                  title: currentItem.title,
                  description: currentItem.description,
                  showBackButton: !isFirstPage,
                  onNext: () {
                    if (currentIndex < onboardingData.length - 1) {
                      setState(() {
                        currentIndex++;
                      });
                    } else {
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  },
                  onBack: () {
                    if (currentIndex > 0) {
                      setState(() {
                        currentIndex--;
                      });
                    }
                  },
                  buttonText: isLastPage ? "Finish" : "Next"
              ),
            ),
          ),
        ],
      ),
    );
  }
}