import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kfc/constants/constants.dart';
import 'package:kfc/controller/provider/auth_provider.dart';
import 'package:kfc/controller/services/push_notification_services.dart';
import 'package:kfc/view/authscreens/login_screen.dart';
import 'package:kfc/view/authscreens/signin_logic_screen.dart';
import 'package:kfc/view/bottomnavigationbar/bottom_navigationbar_screen.dart';
import 'package:kfc/view/otpscreen/otp_screen.dart';
import 'package:kfc/view/userregistrationscreen/user_registration_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class MobileAuthService {
  //  Check authentication
  static bool checkAuthentication(BuildContext context) {
    User? user = auth.currentUser;
    if (user == null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreenUser()),
          (route) => false);
      return false;
    }
    // Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (context) => const BottomNavigationUser()),
    //     (route) => false);

    checkUserRegistration(context: context);
    return true;
  }

  // Receive and verify OTP
  static receiveOTP(
      {required BuildContext context, required mobileNumber}) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: mobileNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          log(credential.toString());
        },
        verificationFailed: (FirebaseAuthException exception) {
          log(exception.toString());
          throw Exception(exception);
        },
        codeSent: (String verificationID, int? resendToken) {
          context
              .read<MobileAuthProvier>()
              .updateVerificationID(verificationID);
          Navigator.push(
            context,
            PageTransition(
                child: const OtpScreen(), type: PageTransitionType.rightToLeft),
          );
        },
        codeAutoRetrievalTimeout: (String verificationID) {},
      );
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static verifyOTP({required BuildContext context, required String otp}) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: context.read<MobileAuthProvier>().verificationId!,
          smsCode: otp);
      await auth.signInWithCredential(credential);
      // Navigator.push(context, )
      Navigator.push(
        context,
        PageTransition(
            child: const SigninLogiceScreen(),
            type: PageTransitionType.rightToLeft),
      );
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static checkUserRegistration({required BuildContext context}) async {
    bool userIsRegistered = false;

    try {
      await firestore
          .collection('User')
          .where("userID", isEqualTo: auth.currentUser!.uid)
          .get()
          .then((value) {
        value.size > 0 ? userIsRegistered = true : userIsRegistered = false;
        log("User is registered: $userIsRegistered");

        if (userIsRegistered) {
          PushNotificationServices.initializeFCM();
          Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                  child: const BottomNavigationUser(),
                  type: PageTransitionType.rightToLeft),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                  child: const UserRegistrationScreen(),
                  type: PageTransitionType.rightToLeft),
              (route) => false);
        }
      });
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }
}
