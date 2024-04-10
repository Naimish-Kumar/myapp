import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
 late AnimationController _animationController;
 late Animation<double> _animation;

   _navigateToHome() async {
    // Request permissions here
    await Permission.storage.request();
    // Wait for 2 seconds
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
  }

  @override
  void initState() {
    super.initState();
    _navigateToHome();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    // Navigate to next screen after some delay
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MainScreen()));
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF5B0E2D), // dark purple
            Color(0xFFE53935), // red
          ],
        ),
        ),
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Image.asset('assets/images/logo.png',height: 100,),
            ),
          ),
        ),
      ),
    );
  }
}
