import 'package:flutter/material.dart';
import 'package:product_list_app/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  //ekran ilk açıldığında bir kere çalışır
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      //ekran hala açık mı eğer kapandıysa devam etme
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OnboardingScreen(),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: const Color(0xFFE4DFD9),
      body: Center(
        child: Hero(
          tag: 'Logo',
          child: Image.asset("assets/images/logo.jpg"),
        ),
      ),
    );
  }
}