import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movies/auth/screens/forgetPassword_screen.dart';
import 'package:movies/auth/screens/register_screen.dart';
import 'package:movies/home/home_screen.dart';
import 'auth/screens/login_screen.dart';
import 'auth/firebase_options.dart';
import 'splash_screen.dart';
import 'OnBording/onboarding_screen.dart';
import 'OnBording/first_onbording.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        ForgetpasswordScreen.routeName: (context) => const ForgetpasswordScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}
