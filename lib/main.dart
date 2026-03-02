import 'package:flutter/material.dart';
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
      initialRoute: MovieOnboardingScreen.routeName,
      routes: {
        MovieOnboardingScreen.routeName: (context) => const MovieOnboardingScreen(),
        OnboardingScreen.routeName: (context) =>  const OnboardingScreen(),


      },
    );
  }
}
