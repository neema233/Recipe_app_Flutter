import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe_app/pages/home.page.dart';
import 'package:recipe_app/pages/sign_in.page.dart';
import 'package:recipe_app/utlis/colors_and_text.utlis.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utlis/images.utlis.dart';
import '../utlis/routes.utlis.dart';

class Register_Page extends StatefulWidget {
  @override
  State<Register_Page> createState() => _Register_PageState();
}

class _Register_PageState extends State<Register_Page> {
  late TextEditingController fullnameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> fromKey;
  static final RegExp nameRegExp = RegExp('[a-zA-Z]');
  bool obsecureText = true;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    fullnameController = TextEditingController();
    fromKey = GlobalKey<FormState>();
    super.initState();
  }

  void toggleObsecure() {
    obsecureText = !obsecureText;
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(fit: StackFit.loose, children: [
      backgroundImage(),
      Container(
        color: Colors.black38,
        child: Column(
          children: [
            logo(),
            SizedBox(
              height: 20,
            ),
            introText(),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: fromKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FullName(),
                    SizedBox(
                      height: 15,
                    ),
                    Email(),
                    SizedBox(
                      height: 15,
                    ),
                    Password(),
                    SizedBox(
                      height: 20,
                    ),
                    startButton(),
                    SizedBox(
                      height: 20,
                    ),
                    account()
                  ],
                ),
              ),
            )
          ],
        ),
      )
    ]));
  }

  TextFormField FullName() {
    return TextFormField(
        cursorColor: Color(0xFFB2B7C6),
        style: TextStyle(color: Colors.white),
        controller: fullnameController,
        decoration: const InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF4F5052))),
          focusColor: Color(0xFFB2B7C6),
          label: Text(
            'Full Name',
            style: TextStyle(color: Color(0xFFB2B7C6), fontFamily: 'Hellix'),
          ),
          prefixIcon: Icon(
            Icons.person_outlined,
            color: Color(0xFFB2B7C6),
          ),
        ),
        validator: (value) => value!.isEmpty
            ? 'Enter Your Name'
            : (nameRegExp.hasMatch(value) ? null : 'Enter a Valid Name'));
  }

  TextFormField Email() {
    return TextFormField(
        cursorColor: Color(0xFFB2B7C6),
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        decoration: const InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF4F5052))),
          focusColor: Color(0xFFB2B7C6),
          label: Text(
            'Email',
            style: TextStyle(color: Color(0xFFB2B7C6), fontFamily: 'Hellix'),
          ),
          prefixIcon: Icon(
            Icons.email,
            color: Color(0xFFB2B7C6),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'email is required';
          }

          if (!EmailValidator.validate(value)) {
            return 'Not Valid Email';
          }
          return null;
        });
  }

  TextFormField Password() {
    return TextFormField(
        cursorColor: Color(0xFFB2B7C6),
        style: TextStyle(color: Colors.white),
        obscureText: obsecureText,
        controller: passwordController,
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF4F5052))),
            focusColor: Color(0xFFB2B7C6),
            label: const Text(
              'Password',
              style: TextStyle(color: Color(0xFFB2B7C6), fontFamily: "Hellix"),
            ),
            prefixIcon: Icon(Icons.lock_outline_rounded,
                color: Color(ColorsConst.containerBackgroundColor)),
            suffixIcon: InkWell(
              onTap: () => toggleObsecure(),
              child: Icon(
                obsecureText ? Icons.visibility_off : Icons.visibility,
                color: Color(0XFFB2B7C6),
              ),
            )),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'password is required';
          }

          if (value.length < 6) {
            return 'password too short';
          }
          return null;
        });
  }

  Padding account() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Already registered? ",
              style: TextStyle(
                  fontFamily: "Hellix",
                  fontSize: 14,
                  color: Color(0xFFB2B7C6))),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RoutesCons.signPage);
            },
            child: Text("Sign In.",
                style: TextStyle(
                    fontFamily: "Hellix",
                    fontSize: 14,
                    color: Color(0xFFF55A00))),
          ),
        ],
      ),
    );
  }

  Text introText() {
    return Text("Register",
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Hellix',
            fontSize: 16,
            fontWeight: FontWeight.bold));
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
    return Center(
      child: Image.asset(ImagesPath.logoimage),
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
          color: Color(0xFFF55A00),
          onPressed: () async {
            if ((fromKey.currentState?.validate() ?? false)) {
              GetIt.I.get<SharedPreferences>().setBool('isLogin', true);
              GetIt.I
                  .get<SharedPreferences>()
                  .setString('FullName', fullnameController.text);

              Navigator.pushNamed(context, RoutesCons.homePage);
            }
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
