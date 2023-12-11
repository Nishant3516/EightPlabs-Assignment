import 'package:eightplabs/controllers/controllers.dart';
import 'package:eightplabs/services/services.dart';
import 'package:eightplabs/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({super.key});

  @override
  State createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen>
    with TickerProviderStateMixin {
  List<Map<String, dynamic>> classes = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List<Map<String, dynamic>>> loadClasses() async {
    final String? token = await AuthController().getToken();
    if (token != null) {
      try {
        return await ApiService.fetchClasses(token);
      } catch (e) {
        // print(e);
        return [];
      }
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Classes"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: loadClasses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error loading classes"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No classes available"),
            );
          } else {
            classes = snapshot.data!;
            return Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ListView.builder(
                itemCount: classes.length,
                shrinkWrap: true,
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
                    child: IndClassBox(indclass: classes[index]),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
