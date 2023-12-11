import 'package:eightplabs/controllers/controllers.dart';
import 'package:eightplabs/globalWidgets/global_widgets.dart';
import 'package:eightplabs/screens/screens.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final Map<String, dynamic>? userDetails;
  const HomeScreen({
    super.key,
    this.userDetails,
  });

  @override
  Widget build(BuildContext context) {
    void logOut() {
      AuthController().clearUserData();
      NavigatorWidget()
          .screenPushReplacement(context, const OnboardingScreen());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: logOut,
            icon: const Icon(Icons.logout_outlined),
            tooltip: "Logout",
          )
        ],
      ),
      body: Center(
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to EightPLabs!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const YSpace(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (userDetails != null) {
                      NavigatorWidget().screenReplacement(
                        context,
                        ProfileScreen(
                          userData: userDetails!,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Check Profile'),
                  ),
                ),
                const YSpace(height: 10),
                ElevatedButton(
                  onPressed: () {
                    NavigatorWidget()
                        .screenReplacement(context, const ClassesScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Check Classes'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
