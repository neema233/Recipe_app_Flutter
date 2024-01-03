import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe_app/pages/home.page.dart';
import 'package:recipe_app/pages/register.page.dart';
import 'package:recipe_app/utlis/images.utlis.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    await Future.delayed(const Duration(seconds: 1));
    if (GetIt.I.get<SharedPreferences>().getBool('isLogin') ?? false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomePage()));
      // go to home page
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Register_Page()));
      // go to Register page
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
