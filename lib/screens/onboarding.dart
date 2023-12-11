import 'package:eightplabs/globalWidgets/global_widgets.dart';
import 'package:eightplabs/screens/screens.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: RadialGradient(
                    focalRadius: 50, colors: [Colors.blue, Colors.black])),
            child: Image.asset("assets/images/login.png",
                height: MediaQuery.sizeOf(context).height * 0.55),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 150,
                  width: 200,
                ),
                const YSpace(height: 10),
                IndividualButton(
                  buttonText: "Login",
                  buttonFunction: () {
                    NavigatorWidget()
                        .screenReplacement(context, const LogInScreen());
                  },
                  backgroundColor: Colors.black,
                  borderColor: Colors.white,
                ),
                const YSpace(height: 10),
                IndividualButton(
                  buttonText: "Register",
                  buttonFunction: () {
                    NavigatorWidget()
                        .screenReplacement(context, const RegisterScreen());
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
