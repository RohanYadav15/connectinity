import 'package:connectnity/models/post_provider.dart';
import 'package:connectnity/models/user_provider.dart';
import 'package:connectnity/screens/drawer_screen.dart';
import 'package:connectnity/screens/home_screen.dart';
import 'package:connectnity/screens/login_or_registartion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';

class Connectinity extends StatelessWidget {
  const Connectinity({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Provider.of<UserProvider>(context, listen: true).user == null
          ? const LoginOrRegistration()
          : ChangeNotifierProvider<UserProvider>(
              create: (context) => UserProvider(),
              child: const ZoomDrawer(
                menuScreen: DrawerScreen(),
                mainScreen: HomeScreen(),
                borderRadius: 24.0,
                angle: 0.0,
                drawerShadowsBackgroundColor: Colors.grey,
                slideWidth: 250,
                menuBackgroundColor: Colors.lightBlue,
              )),
    );
  }
}
