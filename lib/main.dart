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
      home: const SplashScreen(),
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
            context, HomeScreen(userDetails: userDetails));
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
