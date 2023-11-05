import 'package:connectnity/models/user_provider.dart';
import 'package:connectnity/widgets/button.dart';
import 'package:connectnity/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AdditionalInfoForm extends StatefulWidget {
  final String userId;

  const AdditionalInfoForm({super.key, required this.userId});

  @override
  State<AdditionalInfoForm> createState() => _AdditionalInfoFormState();
}

class _AdditionalInfoFormState extends State<AdditionalInfoForm> {
  bool isOrg = false;
  late final TextEditingController phoneNumberController;
  late final TextEditingController majorController;
  late final TextEditingController userNameController;

  @override
  void initState() {
    phoneNumberController = TextEditingController();
    majorController = TextEditingController();
    userNameController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('Are you an organization'),
            DropdownButton<bool>(
              value: isOrg,
              items: [
                const DropdownMenuItem<bool>(child: Text('Yes'), value: true),
                const DropdownMenuItem<bool>(child: Text('No'), value: false),
              ],
              onChanged: (value) => setState(() => isOrg = value ?? false),
            )
          ],
        ),
        MyTextField(
            hintText: 'Enter your username',
            obscureText: false,
            controller: userNameController),
        MyTextField(
            hintText: 'Enter your phonenumber',
            obscureText: false,
            controller: phoneNumberController),
        MyTextField(
            hintText: 'Enter your major',
            obscureText: false,
            controller: majorController),
        // TODO: change the user data on tap
        MyButton(
            text: 'Submit',
            onTap: () => Provider.of<UserProvider>(context, listen: false)
                .updateUserData(widget.userId, phoneNumberController.text,
                    majorController.text)),
      ],
    );
  }
}
