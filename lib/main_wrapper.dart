import 'package:flutter/material.dart';
import 'home/home_screen.dart';
import 'explore/explore_screen.dart';
import 'search/search_screen.dart';
import 'profile/profile_screen.dart';
import 'home/widgets/bottom_nav_bar.dart';

class MainWrapper extends StatefulWidget {
  static const String routeName = 'main_wrapper';
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const SearchScreen(),
    const ExploreScreen(),
    const ProfileScreen(),
  ];

  void _onTap(int index) {
    if (_currentIndex == index) return;
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: BottomNavBar(currentIndex: _currentIndex, onTap: _onTap),
      ),
    );
  }
}
