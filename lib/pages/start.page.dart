import 'package:flutter/material.dart';
import 'package:recipe_app/pages/register.page.dart';
import 'package:recipe_app/utlis/colors_and_text.utlis.dart';
import 'package:recipe_app/utlis/images.utlis.dart';
import 'package:recipe_app/utlis/numbers.utlis.dart';

import '../utlis/routes.utlis.dart';

class Start_Page extends StatefulWidget {
  @override
  State<Start_Page> createState() => _Start_PageState();
}

class _Start_PageState extends State<Start_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.loose,
        children: [
          backgroundImage(),
          Column(
            children: [
              logo(),
              SizedBox(),
              introText(),
              Spacer(),
              startButton(),
              Sign_in()
            ],
          ),
        ],
      ),
    );
  }

  Padding Sign_in() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RoutesCons.signPage);
        },
        child: Text("Sign In",
            style: TextStyle(
                fontFamily: "Hellix", fontSize: 16, color: Colors.white)),
      ),
    );
  }

  Text introText() {
    return Text("Cooking Done The Easy Way",
        style: TextStyle(
            color: Color(ColorsConst.containerBackgroundColor),
            fontFamily: 'Hellix',
            fontSize: 14));
  }

  Widget backgroundImage() {
    return Image.asset(
      ImagesPath.backgroundimage,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }

  Widget logo() {
    return Padding(
      padding: const EdgeInsets.all(Numbers.appHorizontalPadding),
      child: Center(child: Image.asset(ImagesPath.logoimage)),
    );
  }

  Widget startButton() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          height: 50,
          minWidth: 250,
          color: Color(ColorsConst.mainColor),
          onPressed: () {
            Navigator.pushNamed(context, RoutesCons.registerPage);
          },
          child: Text(
            'Register',
            style: TextStyle(
                fontFamily: "Hellix", fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
