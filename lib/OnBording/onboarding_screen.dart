import 'package:flutter/material.dart';
import 'package:movies/core/app_color.dart';
import 'package:movies/core/app_style.dart';
import '../../auth/login_screen.dart';
import '../core/app_assets.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = 'onboarding';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 1;

  final List<OnboardingData> _pages = [
    OnboardingData(
      image: AppAssets.Acengers,
      title: 'Discover Movies',
      description:
      'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.',
      buttonText: 'Next',
    ),
    OnboardingData(
      image: AppAssets.OppenHeimer,
      title: 'Explore All Genres',
      description:
          'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
      buttonText: 'Next',
      showBack: true,
    ),
    OnboardingData(
      image: AppAssets.BadBoys,
      title: 'Create Watchlists',
      description:
          'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.',
      buttonText: 'Next',
      showBack: true,
    ),
    OnboardingData(
      image: AppAssets.Drstrange,
      title: 'Rate, Review, and Learn',
      description:
          'Share your thoughts on the movies you\'ve watched. Dive deep into film details and help others discover great movies with your reviews.',
      buttonText: 'Next',
      showBack: true,
    ),
    OnboardingData(
      image: AppAssets.poster5,
      title: 'Start Watching Now',
      description: '',
      buttonText: 'Finish',
      showBack: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColor.black),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  SizedBox.expand(
                    child: Image.asset(_pages[index].image, fit: BoxFit.cover),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: index == 1
                            ? Colors.black
                            : const Color(0xFF121312),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _pages[index].title,
                            textAlign: TextAlign.center,
                            style: AppStyle.titletext.copyWith(
                              fontSize: 24,
                            ),
                          ),
                          if (_pages[index].description.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text(
                              _pages[index].description,
                              textAlign: TextAlign.center,
                              style: AppStyle.subtitletext,
                            ),
                          ],
                          const SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: () {
                              if (_currentIndex < _pages.length - 1) {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                Navigator.pushReplacementNamed(
                                  context,
                                  LoginScreen.routeName,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(AppColor.gold),
                              minimumSize: const Size(double.infinity, 56),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              _pages[index].buttonText,
                              style: AppStyle.subtitletext.copyWith(
                                color: const Color(AppColor.black),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (_pages[index].showBack) ...[
                            const SizedBox(height: 12),
                            OutlinedButton(
                              onPressed: () {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(AppColor.gold),
                                ),
                                minimumSize: const Size(double.infinity, 56),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Text(
                                'Back',
                                style: AppStyle.subtitletext.copyWith(
                                  color: const Color(AppColor.gold),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class OnboardingData {
  final String image;
  final String title;
  final String description;
  final String buttonText;
  final bool showBack;

  OnboardingData({
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
    this.showBack = false,
  });
}
