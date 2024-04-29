import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kfc/view/otpscreen/widgets/otp_widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _pinController = TextEditingController();
  final StreamController<ErrorAnimationType> _errorController =
      StreamController<ErrorAnimationType>();

  int resendOTPCounter = 60;

//This is the function for decreasing counter
  void decreaseOTPCounter() async {
    if (resendOTPCounter > 0) {
      setState(() {
        resendOTPCounter -= 1;
      });
      await Future.delayed(const Duration(seconds: 1), () {
        decreaseOTPCounter();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      decreaseOTPCounter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: OtpWidgets(
        text: "Enter the 4-digit code sent to you at 08027012730",
        textEditingController: _pinController,
        errorController: _errorController,
        resendOTP: resendOTPCounter,
        nextButton: () {
          print("Next button clicked");
        },
        goBackButton: () => print("Back button clicked"),
      ),
    );
  }
}
