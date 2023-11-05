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

class RegistrationScreen extends StatefulWidget {
  final Function()? onTap;
  const RegistrationScreen({super.key, required this.onTap});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: widget.onTap,
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Register'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              MyTextField(
                  hintText: 'Email',
                  obscureText: false,
                  controller: emailController),
              SizedBox(height: 10.0),
              MyTextField(
                  hintText: 'Password',
                  obscureText: true,
                  controller: passwordController),
              MyTextField(
                  hintText: 'Confirm Password',
                  obscureText: false,
                  controller: confirmPasswordController),
              MyButton(
                  text: 'Register',
                  onTap: () async {
                    Provider.of<UserProvider>(context, listen: false)
                        .createUserWithEmailAndPassword(
                            emailController.text, passwordController.text);
                    widget.onTap!();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
