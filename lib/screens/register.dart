import 'package:flutter/material.dart';
import 'package:eightplabs/controllers/controllers.dart';
import 'package:eightplabs/globalWidgets/global_widgets.dart';
import 'package:eightplabs/screens/screens.dart';
import 'package:eightplabs/widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final signUpFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  void _redirectToLoginScreen(BuildContext context) async {
    if (signUpFormKey.currentState!.validate()) {
      try {
        await AuthController().registerUser(
          userNameController.text,
          passwordController.text,
          emailController.text,
        );

        showDialog(
          context: context,
          builder: (context) => _buildSuccessDialog(context),
        );

        await Future.delayed(const Duration(seconds: 2));
        Navigator.of(context).pop();
        NavigatorWidget().screenPushReplacement(context, const LogInScreen());
      } catch (e) {
        // print(e);
      }
    }
  }

  Widget _buildSuccessDialog(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/success.png",
              height: 150,
              width: 150,
            ),
            const Text(
              "Registration Successful",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text("Redirecting to Login Screen ...")
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Register to start the journey!!',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const YSpace(height: 20),
            const Text(
              'Welcome back! Sign in using your social account or email to continue us',
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
            _buildRegistrationForm(),
            const YSpace(height: 10),
            IndividualButton(
              buttonFunction: () => _redirectToLoginScreen(context),
              buttonText: 'Register',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return Form(
      key: signUpFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            decoration: _buildInputDecoration("Email"),
            validator: (value) => _validateEmail(value),
          ),
          const YSpace(height: 10),
          TextFormField(
            controller: userNameController,
            validator: (value) => _validateUsername(value),
            decoration: _buildInputDecoration("Username"),
          ),
          const YSpace(height: 10),
          TextFormField(
            controller: passwordController,
            obscureText: !isPasswordVisible,
            autocorrect: false,
            decoration: _buildInputDecorationWithSuffix(
              "Password",
              Icons.visibility_outlined,
              () => _togglePasswordVisibility(),
            ),
            validator: (value) => _validatePassword(value),
          ),
          const YSpace(height: 10),
          TextFormField(
            controller: confirmPasswordController,
            obscureText: !isConfirmPasswordVisible,
            decoration: _buildInputDecorationWithSuffix(
              "Confirm Password",
              Icons.visibility_outlined,
              () => _toggleConfirmPasswordVisibility(),
            ),
            validator: (value) => _validateConfirmPassword(value),
          ),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      prefixIcon: const Icon(Icons.email_outlined),
      hintText: hintText,
      filled: true,
      fillColor: Colors.grey[350],
      border: const OutlineInputBorder(
        borderSide: BorderSide(width: 50, color: Colors.black),
      ),
    );
  }

  InputDecoration _buildInputDecorationWithSuffix(
    String hintText,
    IconData suffixIcon,
    void Function() onSuffixTap,
  ) {
    return InputDecoration(
      prefixIcon: const Icon(Icons.lock_outline_rounded),
      hintText: hintText,
      filled: true,
      fillColor: Colors.grey[350],
      suffixIcon: IconButton(
        icon: Icon(suffixIcon),
        onPressed: onSuffixTap,
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(width: 50, color: Colors.black),
      ),
    );
  }

  String? _validateEmail(String? value) {
    final RegExp emailRegExp =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (value == null || value.isEmpty || !emailRegExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validateUsername(String? value) {
    final RegExp userNameRegExp = RegExp(r'^[a-zA-Z][a-zA-Z0-9_-]{2,19}$');
    if (value == null || value.isEmpty || !userNameRegExp.hasMatch(value)) {
      return 'Enter a valid user name';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    final RegExp passwordRegExp = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\-]).{8,}$');
    if (value == null || value.isEmpty || !passwordRegExp.hasMatch(value)) {
      return 'Password must be of at least 8 characters and must contain digits, special characters, and uppercase and lowercase letters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      isConfirmPasswordVisible = !isConfirmPasswordVisible;
    });
  }
}
