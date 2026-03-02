import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'onboarding_screen.dart';
import 'splash_screen.dart';
import 'package:movies/OnBording/First_Onbording.dart';
import 'OnBording/Onbording_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        OnboardingScreen.routeName: (context) => const OnboardingScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),

      initialRoute: MovieOnboardingScreen.routeName,
      routes: {
        MovieOnboardingScreen.routeName: (context) => const MovieOnboardingScreen(),
        OnboardingScreen.routeName: (context) =>  const OnboardingScreen(),
      },
    );
  }
}
