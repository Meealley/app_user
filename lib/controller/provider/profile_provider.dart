import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kfc/controller/services/image_services.dart';
import 'package:kfc/controller/services/user_data_crud_services.dart';
import 'package:kfc/model/user_address_model.dart';
import 'package:kfc/model/user_model.dart';

class ProfileProvider extends ChangeNotifier {
  File? profileImage;
  String? profileImageUrl;
  UserModel? userData;
  List<UserAddressModel> addresses = [];

  pickFoodImageFromGallery(BuildContext context) async {
    profileImage = await ImageServices.pickSingleImage(context: context);
    notifyListeners();
  }

  uploadImageAndGetFoodImageURL(BuildContext context) async {
    List<String> url =
        await ImageServices.uploadImagesToFirebaseStorageAndGetURL(
      images: [profileImage!],
      context: context,
    );
    if (url.isNotEmpty) {
      profileImageUrl = url[0];
      log(profileImageUrl!);
    }
    notifyListeners();
  }

  fetchUserData() async {
    userData = await UserDataCRUDServices.fetchUserData();
    notifyListeners();
  }

  fetchUserAddress() async {
    addresses = await UserDataCRUDServices.fetchAddresses();
    notifyListeners();
  }
}
