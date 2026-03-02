import 'package:flutter/material.dart';
import 'OnBording/first_onbording.dart';
import 'auth/register_screen.dart';
import 'login_screen.dart';
import 'splash_screen.dart';
import 'OnBording/onboarding_screen.dart';

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
        MovieOnboardingScreen.routeName: (context) => const MovieOnboardingScreen(),
        OnboardingScreen.routeName: (context) => const OnboardingScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
      },
    );
  }
}
