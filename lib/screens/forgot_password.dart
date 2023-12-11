import 'package:eightplabs/globalWidgets/global_widgets.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final forgotPasswordFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.sizeOf(context).height * 0.9,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const YSpace(height: 20),
                  const Text(
                    "Don't worry!! Enter your email below to reconnect with us",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const YSpace(height: 20),
                  Form(
                    key: forgotPasswordFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email_outlined),
                            hintText: "Email",
                            filled: true,
                            fillColor: Colors.grey[350],
                            border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 50, color: Colors.black)),
                          ),
                          validator: (value) {
                            final RegExp emailRegExp = RegExp(
                                r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
                            if (value == null ||
                                value.isEmpty ||
                                !emailRegExp.hasMatch(value)) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const YSpace(height: 10),
                        IndividualButton(
                          buttonFunction: () {},
                          buttonText: 'Send Code',
                        ),
                      ],
                    ),
                  )
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Remembered Password? Login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
