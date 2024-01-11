import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe_app/pages/home.page.dart';
import 'package:recipe_app/pages/register.page.dart';
import 'package:recipe_app/utlis/images.utlis.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utlis/routes.utlis.dart';

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
      // go to home page
      Navigator.pushNamed(context, RoutesCons.homePage);
    } else {
      Navigator.pushNamed(context, RoutesCons.registerPage);
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
