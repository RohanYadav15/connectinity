import 'dart:ffi';

import 'package:connectnity/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                CircleAvatar(backgroundColor: Colors.grey),
              ],
            ),
            ListTile(
              title: Text('Profile'),
            ),
            ListTile(
              title: Text('Settings'),
            ),
            ListTile(
              title: Text('Signout'),
              leading: Icon(Icons.logout),
              onTap: () =>
                  Provider.of<UserProvider>(context, listen: false).signOut(),
            ),
          ],
        ),
      ),
    );
  }
}
