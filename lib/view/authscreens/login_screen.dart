import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:kfc/view/authscreens/widgets/login_widget.dart';

class LoginScreenUser extends StatefulWidget {
  const LoginScreenUser({super.key});

  @override
  State<LoginScreenUser> createState() => _LoginScreenUserState();
}

class _LoginScreenUserState extends State<LoginScreenUser> {
  String _selectedCountry = '+234';
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LoginScreenWidget(
      text: "Enter your mobile number",
      onPressed: () {
        log(_controller.text);
      },
      selectedCountry: _selectedCountry,
      controller: _controller,
      onPressNext: () => log("Clicked"),
      onTapCountry: () {
        showCountryPicker(
          context: context,
          showPhoneCode: true,
          onSelect: (Country country) {
            setState(() {
              _selectedCountry = '+${country.phoneCode}';
            });
            log("Select your country: ${country.displayName}");
          },
        );
      },
    );
  }
}
