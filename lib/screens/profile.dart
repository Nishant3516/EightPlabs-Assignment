import 'package:eightplabs/globalWidgets/global_widgets.dart';
import 'package:eightplabs/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  const ProfileScreen({super.key, required this.userData});

  @override
  State createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  final List<String> parameters = [
    "Name",
    "Username",
    "Email",
    "Joined on",
    "Authority"
  ];
  final List<String> parameterKey = [
    "firstName",
    "login",
    "email",
    "createdDate",
    "authorities"
  ];

  String formatIso8601Date(String iso8601String) {
    final DateTime dateTime = DateTime.parse(iso8601String);
    final String day = dateTime.day.toString().padLeft(2, '0');
    final String month = dateTime.month.toString().padLeft(2, '0');
    final String year = dateTime.year.toString();
    return '$day/$month/$year';
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate = widget.userData['createdDate'] != null
        ? formatIso8601Date(widget.userData['createdDate'])
        : '';

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_outlined),
                  ),
                  const Spacer(flex: 1),
                  const Text("Profile",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  const Spacer(flex: 2),
                ],
              ),
              const YSpace(height: 10),
              const PhotoCirlce(),
              const YSpace(height: 10),
              Text(
                widget.userData['login'] ?? 'Username',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              const YSpace(height: 30),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Personal Details",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: parameters.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.0, 1.0),
                        end: const Offset(0.0, 0.0),
                      ).animate(
                        CurvedAnimation(
                          curve: Curves.easeIn,
                          parent: AnimationController(
                            vsync: this,
                            duration: const Duration(milliseconds: 700),
                          )..forward(),
                        ),
                      ),
                      child: IndDetailBox(
                        parameter: parameters[index],
                        parameterValue: widget.userData != null &&
                                widget.userData[parameterKey[index]] is List
                            ? (widget.userData[parameterKey[index]]
                                    as List<dynamic>)
                                .join(', ')
                            : parameterKey[index] == 'createdDate'
                                ? formattedDate
                                : widget.userData[parameterKey[index]] ?? 'N/A',
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
