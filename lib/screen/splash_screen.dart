import 'package:flutter/material.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
     nextScreen();
    super.initState();
  }

  void nextScreen() async{
    await Future.delayed(const Duration(seconds: 3));
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/kiddo world 1.png"),fit: BoxFit.cover)
        ),
      ),
    );
  }
}
