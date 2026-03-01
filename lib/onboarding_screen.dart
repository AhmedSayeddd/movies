import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = 'onboarding';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      image: 'assets/images/page1.png',
      shadowImage: 'assets/images/Rectangle 1.png',
      title: 'Find Your Next\nFavorite Movie Here',
      description: 'Get access to a huge library of movies to suit all tastes. You will surely like it.',
      buttonText: 'Explore Now',
    ),
    OnboardingData(
      image: 'assets/images/2.1.png',
      shadowImage: 'assets/images/2.2.png',
      title: 'Discover Movies',
      description: 'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.',
      buttonText: 'Next',
    ),
    OnboardingData(
      image: 'assets/images/3.1.png',
      shadowImage: 'assets/images/3.2.png',
      title: 'Explore All Genres',
      description: 'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
      buttonText: 'Next',
      showBack: true,
    ),
    OnboardingData(
      image: 'assets/images/4.1.png',
      shadowImage: 'assets/images/4.2.png',
      title: 'Create Watchlists',
      description: 'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.',
      buttonText: 'Next',
      showBack: true,
    ),
    OnboardingData(
      image: 'assets/images/5.1.png',
      shadowImage: 'assets/images/5.2.png',
      title: 'Rate, Review, and Learn',
      description: 'Share your thoughts on the movies you\'ve watched. Dive deep into film details and help others discover great movies with your reviews.',
      buttonText: 'Next',
      showBack: true,
    ),
    OnboardingData(
      image: 'assets/images/6.1.png',
      shadowImage: 'assets/images/6.2.png',
      title: 'Start Watching Now',
      description: '',
      buttonText: 'Finish',
      showBack: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
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
                  // Background Image
                  SizedBox.expand(
                    child: Image.asset(
                      _pages[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Shadow Image Overlay
                  SizedBox.expand(
                    child: Image.asset(
                      _pages[index].shadowImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Content
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                      decoration: BoxDecoration(
                        color: index == 0 ? Colors.transparent : const Color(0xFF121312),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _pages[index].title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (_pages[index].description.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            Text(
                              _pages[index].description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                          const SizedBox(height: 32),
                          // Action Buttons
                          ElevatedButton(
                            onPressed: () {
                              if (_currentIndex < _pages.length - 1) {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFBB3B),
                              minimumSize: const Size(double.infinity, 56),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              _pages[index].buttonText,
                              style: const TextStyle(
                                color: Color(0xFF121212),
                                fontSize: 20,
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
                                side: const BorderSide(color: Color(0xFFFFBB3B)),
                                minimumSize: const Size(double.infinity, 56),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: const Text(
                                'Back',
                                style: TextStyle(
                                  color: Color(0xFFFFBB3B),
                                  fontSize: 20,
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
  final String shadowImage;
  final String title;
  final String description;
  final String buttonText;
  final bool showBack;

  OnboardingData({
    required this.image,
    required this.shadowImage,
    required this.title,
    required this.description,
    required this.buttonText,
    this.showBack = false,
  });
}
