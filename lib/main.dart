import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_home/screens/Home/homescreen.dart';
import 'package:rent_home/screens/Home/map_screen.dart';
import 'package:rent_home/screens/onboarding.dart';
import 'package:rent_home/screens/profile_screen.dart';
import 'package:rent_home/widgets/bottom_nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xffBF5973),
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.latoTextTheme(),
        primaryColor: const Color(0xffC14464),
      ),
      home:  OnboardingPage(),
    );
  }
}
