import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movies/core/app_assets.dart';
import 'package:movies/core/app_color.dart';
import 'package:movies/core/app_style.dart';
import 'package:movies/OnBording/first_onbording.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/core/cache/cache_helper.dart';
import 'package:movies/auth/screens/login_screen.dart';
import 'package:movies/main_wrapper.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'splash';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _handleNavigation();
  }

  Future<void> _handleNavigation() async {
    await Future.delayed(const Duration(seconds: 2));
    
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (mounted) Navigator.pushReplacementNamed(context, MainWrapper.routeName);
      return;
    }

    final bool onboardingSeen = await CacheHelper.getData('onboarding_seen') ?? false;
    if (mounted) {
      if (onboardingSeen) {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      } else {
        Navigator.pushReplacementNamed(context, MovieOnboardingScreen.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColor.black),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppAssets.logo, height: 150),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppAssets.route,
                    width: 180,
                    height: 76,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Supervised by Mohamed Nabil',
                    style: AppStyle.summarytext.copyWith(fontSize: 14),
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
