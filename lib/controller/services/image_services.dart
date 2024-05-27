import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kfc/constants/constants.dart';
import 'package:kfc/controller/services/toast_message_services.dart';

class ImageServices {
  static uploadImagesToFirebaseStorageAndGetURL(
      {required List<File> images, required BuildContext context}) async {
    List<String> imagesURL = [];
    String sellerUID = auth.currentUser!.uid;
    await Future.forEach(images, (image) async {
      String imageName = '$sellerUID${uuid.v1().toString()}';
      Reference ref =
          storage.ref().child('RestaurantBannerImages').child(imageName);
      await ref.putFile(File(image.path));
      String imageURL = await ref.getDownloadURL();
      imagesURL.add(imageURL);
    });

    return imagesURL;
  }

  static pickSingleImage({required BuildContext context}) async {
    File? selectedImage;
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    XFile? filePick = pickedFile;
    if (filePick != null) {
      selectedImage = File(filePick.path);
      return selectedImage;
    } else {
      // Show toast Error message

      ToastService.sendScaffoldAlert(
        msg: "No Images Selected",
        toastStatus: 'WARNING',
        context: context,
      );
    }
    // log("The images are \n ${selectedImages.toList().toString()}");
    // return selectedImage;
  }
}
