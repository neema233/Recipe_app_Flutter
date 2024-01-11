import 'package:flutter/material.dart';
import 'package:recipe_app/pages/home.page.dart';
import 'package:recipe_app/pages/register.page.dart';
import 'package:recipe_app/pages/sign_in.page.dart';
import 'package:recipe_app/pages/splash.page.dart';
import 'package:recipe_app/pages/start.page.dart';
import '../utlis/routes.utlis.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesCons.homePage:
        return MaterialPageRoute(
          builder:
              (_) => /*BlocProvider(
            create: (BuildContext contxt) => Cubit,
            child:*/
                  const HomePage(),
          //),
        );

      case RoutesCons.registerPage:
        return MaterialPageRoute(builder: (_) => Register_Page());
      case RoutesCons.splashPage:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case RoutesCons.signPage:
        return MaterialPageRoute(builder: (_) => Sign_In());
      case RoutesCons.startPage:
        return MaterialPageRoute(builder: (_) => Start_Page());
    }
    return null;
  }
}
