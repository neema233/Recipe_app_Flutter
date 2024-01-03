import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe_app/pages/splash.page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    var preference = await SharedPreferences.getInstance();

    GetIt.I.registerSingleton<SharedPreferences>(preference);
  } catch (e) {
    // ignore: avoid_print
    print(
        // ignore: unnecessary_brace_in_string_interps
        '=========================Error In init Prefrences ${e}========================');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      // ignore: avoid_print
    );
  }
}
