import 'package:eightplabs/controllers/controllers.dart';
import 'package:eightplabs/globalWidgets/global_widgets.dart';
import 'package:eightplabs/screens/screens.dart';
import 'package:eightplabs/services/services.dart';
import 'package:eightplabs/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final signInFormKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isRememberMeToggled = true;
  bool loading = false;

  void validateLogin(bool saveLoginData) async {
    final Map<String, dynamic>? userData;
    if (signInFormKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      try {
        if (saveLoginData) {
          await AuthController().authenticateUser(
            userNameController.text,
            passwordController.text,
            saveLoginData,
          );
          userData = await AuthController().fetchUserDetailsfromSP();
          NavigatorWidget().screenPushReplacement(
            context,
            HomeScreen(userDetails: userData),
          );
        } else {
          final String? userToken = await AuthController().getUserToken(
            userNameController.text,
            passwordController.text,
            saveLoginData,
          );
          if (userToken != null) {
            userData = await ApiService().fetchUserDetails(userToken);
            NavigatorWidget().screenPushReplacement(
              context,
              HomeScreen(
                userDetails: userData,
                token: userToken,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error authenticating the user'),
              ),
            );
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid username or password'),
          ),
        );
      } finally {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome Back!!',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const YSpace(height: 20),
              const Text(
                'Welcome back! Sign in using your social account or email to continue with us',
                style: TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const YSpace(height: 20),
              SocialAuth(
                onGoogleSignInComplete: () {},
              ),
              const YSpace(height: 20),
              const Text("OR"),
              const YSpace(height: 20),
              Form(
                  key: signInFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: userNameController,
                        validator: (value) {
                          final RegExp userNameRegExp =
                              RegExp(r'^[a-zA-Z][a-zA-Z0-9_-]{2,19}$');

                          if (value == null ||
                              value.isEmpty ||
                              !userNameRegExp.hasMatch(value)) {
                            return 'Enter a valid user name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.contact_page_outlined),
                          filled: true,
                          fillColor: Colors.grey[350],
                          hintText: "Username",
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 50, color: Colors.black)),
                        ),
                      ),
                      const YSpace(height: 10),
                      TextFormField(
                        controller: passwordController,
                        obscureText: !isPasswordVisible,
                        autocorrect: false,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          filled: true,
                          fillColor: Colors.grey[350],
                          hintText: "Password",
                          suffixIcon: IconButton(
                            icon: !isPasswordVisible
                                ? const Icon(Icons.visibility_outlined)
                                : const Icon(Icons.visibility_off_outlined),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 50, color: Colors.black)),
                        ),
                        validator: (value) {
                          // final RegExp passwordRegExp = RegExp(
                          //     r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\-]).{8,}$');
                          // if (value == null ||
                          //     value.isEmpty ||
                          //     !passwordRegExp.hasMatch(value)) {
                          //   return 'Password must be of atleast 8 characters and must contain digits, special character annd uppercase and lowercase letters';
                          // }
                          return null;
                        },
                      ),
                    ],
                  )),
              const YSpace(height: 10),
              loading
                  ? const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: CircularProgressIndicator(),
                    )
                  : IndividualButton(
                      buttonFunction: () => validateLogin(isRememberMeToggled),
                      buttonText: 'Log in',
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text("Remember me?"),
                      Switch(
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.grey,
                        activeColor: Colors.black,
                        activeTrackColor: Colors.grey,
                        value: isRememberMeToggled,
                        onChanged: (value) => setState(() {
                          isRememberMeToggled = value;
                        }),
                      ),
                    ],
                  ),
                  TextButton(
                    child: const Text('Forgot Password?'),
                    onPressed: () {
                      NavigatorWidget().screenReplacement(
                          context, const ForgotPasswordScreen());
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
