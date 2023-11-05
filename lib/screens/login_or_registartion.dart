import 'package:connectnity/models/user_provider.dart';
import 'package:connectnity/screens/login_screen.dart';
import 'package:connectnity/screens/registration_screen.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class LoginOrRegistration extends StatefulWidget {
  const LoginOrRegistration({super.key});

  @override
  State<LoginOrRegistration> createState() => _LoginOrRegistrationState();
}

class _LoginOrRegistrationState extends State<LoginOrRegistration> {
  bool isLoginState = true;

  @override
  Widget build(BuildContext context) {
    return isLoginState
        ? LoginScreen(onTap: () => setState(() => isLoginState = false))
        : RegistrationScreen(onTap: () => setState(() => isLoginState = true));
  }
}
