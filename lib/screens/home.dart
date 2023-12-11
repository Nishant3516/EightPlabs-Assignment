import 'package:eightplabs/controllers/controllers.dart';
import 'package:eightplabs/globalWidgets/global_widgets.dart';
import 'package:eightplabs/screens/screens.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final Map<String, dynamic>? userDetails;
  final String? token;

  const HomeScreen({
    Key? key,
    this.token,
    this.userDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void logOut() {
      AuthController().clearUserData();
      NavigatorWidget()
          .screenPushReplacement(context, const OnboardingScreen());
    }

    Map<String, Color> getGreeting() {
      final currentTime = DateTime.now().hour;

      if (currentTime >= 5 && currentTime < 12) {
        return {'Good Morning!!': Colors.yellow[400]!};
      } else if (currentTime >= 12 && currentTime < 17) {
        return {'Good Afternoon!!': Colors.yellow[600]!};
      } else if (currentTime >= 17 && currentTime < 20) {
        return {'Good Evening!!': Colors.orange[600]!};
      } else {
        return {'Good Night!!': Colors.grey[800]!};
      }
    }

    Widget buildActionButton({
      required String label,
      required String imagePath,
      required Color backgroundColor,
      required Color boxShadowColor,
    }) {
      return GestureDetector(
        onTap: () {
          if (label == "Check Profile" && userDetails != null) {
            NavigatorWidget().screenReplacement(
              context,
              ProfileScreen(userData: userDetails!),
            );
          } else if (label == "Check Classes") {
            NavigatorWidget().screenReplacement(
              context,
              ClassesScreen(token: token),
            );
          }
        },
        child: Container(
          height: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[50],
            boxShadow: [
              BoxShadow(
                color: boxShadowColor.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(
              color: boxShadowColor,
              width: 1,
            ),
          ),
          width: MediaQuery.of(context).size.width * 0.6,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  width: 90,
                  height: 90,
                  color: boxShadowColor,
                ),
                const YSpace(height: 20),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: logOut,
            icon: const Icon(Icons.logout_outlined),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          heightFactor: 1.05,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                getGreeting().keys.first,
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: getGreeting().values.first,
                ),
              ),
              YSpace(height: MediaQuery.sizeOf(context).height * 0.01),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Welcome to ",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    "EightPlabs",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(20, 39, 79, 1),
                    ),
                  ),
                ],
              ),
              YSpace(height: MediaQuery.of(context).size.height * 0.06),
              buildActionButton(
                label: "Check Profile",
                imagePath: "assets/icons/profile.png",
                backgroundColor: const Color(0xFFFFC3A0),
                boxShadowColor: const Color(0xFFFFC3A0),
              ),
              const YSpace(height: 20),
              buildActionButton(
                label: "Check Classes",
                imagePath: "assets/icons/class.png",
                backgroundColor: const Color(0xFFD1A7FF),
                boxShadowColor: const Color(0xFFD1A7FF),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
