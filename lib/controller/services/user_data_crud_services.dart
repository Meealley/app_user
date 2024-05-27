import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kfc/constants/constants.dart';
import 'package:kfc/controller/services/toast_message_services.dart';
import 'package:kfc/model/address_model.dart';
import 'package:kfc/model/user_address_model.dart';
import 'package:kfc/model/user_model.dart';
import 'package:kfc/view/authscreens/signin_logic_screen.dart';
import 'package:page_transition/page_transition.dart';

class UserDataCRUDServices {
  static registerUser(UserModel data, BuildContext context) async {
    try {
      await firestore
          .collection("User")
          .doc(auth.currentUser!.uid)
          .set(data.toMap())
          .whenComplete(() {
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              child: const SigninLogiceScreen(),
              type: PageTransitionType.rightToLeft,
            ),
            (route) => false);
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static addAddress(UserAddressModel data, BuildContext context) async {
    try {
      await firestore
          .collection("Address")
          .doc(auth.currentUser!.uid)
          .set(data.toMap())
          .whenComplete(() {
        ToastService.sendScaffoldAlert(
          msg: "Address Added Successfully!",
          toastStatus: "SUCCESS",
          context: context,
        );
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     PageTransition(
        //       child: const SigninLogiceScreen(),
        //       type: PageTransitionType.rightToLeft,
        //     ),
        //     (route) => false);
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static fetchUserData() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('User').doc(auth.currentUser!.uid).get();

      UserModel data = UserModel.fromMap(snapshot.data()!);
      return data;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static fetchAddresses() async {
    List<UserAddressModel> addresses = [];

    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('Address')
          .where('userID', isEqualTo: auth.currentUser!.uid)
          .get();
      snapshot.docs.forEach((element) {
        addresses.add(UserAddressModel.fromMap(element.data()));
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
    return addresses;
  }
}
