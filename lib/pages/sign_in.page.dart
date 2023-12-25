import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/pages/home.page.dart';
import 'package:recipe_app/pages/register.page.dart';
import 'package:recipe_app/services/prefrences.services.dart';

class Sign_In extends StatefulWidget {
  @override
  State<Sign_In> createState() => _Sign_InState();
}

class _Sign_InState extends State<Sign_In> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  late GlobalKey<FormState> fromKey;

  bool obsecureText = true;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
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
      Column(
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
                  Email(),
                  SizedBox(
                    height: 15,
                  ),
                  Password(),
                  SizedBox(
                    height: 20,
                  ),
                  forget_pass(),
                  SizedBox(
                    height: 20,
                  ),
                  Sign_inButton(),
                  SizedBox(
                    height: 20,
                  ),
                  account()
                ],
              ),
            ),
          )
        ],
      )
    ]));
  }

  Row forget_pass() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {},
          child: Text(
            "Forget Password?",
            style: TextStyle(
                color: Color(0xFF128FAE), fontSize: 14, fontFamily: "Hellix"),
          ),
        ),
      ],
    );
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
            prefixIcon: InkWell(
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
          Text("Don't have an account? ",
              style: TextStyle(
                  fontFamily: "Hellix",
                  fontSize: 14,
                  color: Color(0xFFB2B7C6))),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Register_Page()));
            },
            child: Text("Register.",
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
    return Text("Sign In",
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Hellix',
            fontSize: 16,
            fontWeight: FontWeight.bold));
  }

  Widget backgroundImage() {
    return Image.asset(
      'images/Mask Group 9.png',
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }

  Widget logo() {
    return Center(
      child: Image.asset('images/Logo (1).png'),
    );
  }

  Widget Sign_inButton() {
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
            if (fromKey.currentState?.validate() ?? false) {
              await PrefrencesService.prefs?.setBool('isLogin', true);

              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => HomePage()));
            }
          },
          child: Text(
            'Sign In',
            style: TextStyle(
                fontFamily: "Hellix", fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
