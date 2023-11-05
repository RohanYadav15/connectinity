import 'package:connectnity/models/user_provider.dart';
import 'package:connectnity/screens/drawer_screen.dart';
import 'package:connectnity/screens/home_screen.dart';
import 'package:connectnity/widgets/button.dart';
import 'package:connectnity/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onTap;

  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    Provider.of<UserProvider>(context, listen: false).signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Spacer(),
              Image.asset(
                'assets/images/app_icon.png',
                scale: .75,
              ),
              const Text(
                'Connectinity',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              MyTextField(
                  hintText: 'Email',
                  obscureText: false,
                  controller: emailController),
              SizedBox(height: 10.0),
              MyTextField(
                  hintText: 'Password',
                  obscureText: true,
                  controller: passwordController),
              MyButton(
                  text: 'Sign In',
                  onTap: () => Provider.of<UserProvider>(context, listen: false)
                      .signInWithEp(
                          emailController.text, passwordController.text)),
              Row(
                children: [
                  Text("Don't have an account? "),
                  GestureDetector(
                    child: Text("Register"),
                    onTap: widget.onTap,
                  )
                ],
              ),
              Spacer(),
              ElevatedButton.icon(
                onPressed:
                    Provider.of<UserProvider>(context, listen: false).login,
                icon: Image.asset(
                  'assets/images/google_logo.png',
                  fit: BoxFit.contain,
                  height: 50,
                ),
                label: Text('Sign In with Google',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
