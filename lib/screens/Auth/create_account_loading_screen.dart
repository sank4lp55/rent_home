import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rent_home/screens/Home/homescreen.dart';

import '../../widgets/bottom_nav.dart';

class CreateAccountLoadingScreen extends StatefulWidget {
  const CreateAccountLoadingScreen({super.key});

  @override
  _CreateAccountLoadingScreenState createState() => _CreateAccountLoadingScreenState();
}

class _CreateAccountLoadingScreenState extends State<CreateAccountLoadingScreen> {
  final List<String> _messages = [
    "Creating your account...",
    "Setting up your profile...",
    "Almost there...",
    "Welcome aboard!"
  ];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startMessageRotation();
  }

  void _startMessageRotation() {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _messages.length;
      });

      // Check if we've reached the last message
      if (_currentIndex == 0) {
        // Navigate to BottomNav when the last message is shown
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homescreen()),
        );
      } else {
        _startMessageRotation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie Animation
            Lottie.asset('assets/Animation - 1729069558573.json', height: 170),

            // Text below the animation
            Text(
              _messages[_currentIndex],
              style: TextStyle(fontSize: 18, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
