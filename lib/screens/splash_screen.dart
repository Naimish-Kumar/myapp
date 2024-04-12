import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/screens/dashboard_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _navigateToHome() async {
    // Request permissions here
    await Permission.storage.request();
    // Wait for 2 seconds
    await Future.delayed(const Duration(seconds: 4));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Dashboard()));
  }

  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple,
              Colors.blue, // dark purple
              Colors.red,
              Colors.pink // red
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(height:20),
            const Text(
              "Unleash Your Soundtrack",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Nunito Regular',
                  color:Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
