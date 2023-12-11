import 'dart:async';

import 'package:eightplabs/controllers/controllers.dart';
import 'package:eightplabs/globalWidgets/global_widgets.dart';
import 'package:eightplabs/screens/screens.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EightPlabs',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const ShowIcon(),
    );
  }
}

class ShowIcon extends StatefulWidget {
  const ShowIcon({super.key});

  @override
  State<ShowIcon> createState() => _ShowIconState();
}

class _ShowIconState extends State<ShowIcon> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => NavigatorWidget()
            .screenPushReplacement(context, const SplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      color: Colors.white,
      child: Image.asset(
        "assets/images/logo.png",
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    final String? token = await AuthController().getToken();
    if (token != null) {
      final userDetails = await AuthController().fetchUserDetailsfromSP();

      if (userDetails != null) {
        NavigatorWidget().screenPushReplacement(
            context,
            HomeScreen(
              userDetails: userDetails,
              token: token,
            ));
      } else {
        NavigatorWidget()
            .screenPushReplacement(context, const OnboardingScreen());
      }
    } else {
      NavigatorWidget()
          .screenPushReplacement(context, const OnboardingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
