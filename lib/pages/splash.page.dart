import 'package:flutter/material.dart';
import 'package:recipe_app/pages/home.page.dart';
import 'package:recipe_app/pages/start.page.dart';
import 'package:recipe_app/services/prefrences.services.dart';
import 'package:recipe_app/utlis/images.utlis.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    initSplash();
    super.initState();
  }

  void initSplash() async {
    await Future.delayed(const Duration(seconds: 0));
    if (PrefrencesService.checkUser()) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomePage()));
      // go to home page
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Start_Page()));
      // go to login page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(ImagesPath.backgroundimage),
      ),
    );
  }
}
