import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kfc/constants/constants.dart';
import 'package:kfc/controller/services/apis.dart';
import 'package:http/http.dart' as http;
import 'package:kfc/controller/services/keys.dart';
import 'package:kfc/model/driver_model.dart';

class PushNotificationServices {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static Future initializeFirebaseMessaging() async {
    await firebaseMessaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(firebaseMessagingForegroundHandler);
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {}
  static Future<void> firebaseMessagingForegroundHandler(
      RemoteMessage message) async {}

  static Future getToken() async {
    String? token = await firebaseMessaging.getToken();

    log("FCM token:  \n$token");
    await firestore
        .collection('User')
        .doc(auth.currentUser!.uid)
        .update({'cloudMessagingToken': token});
  }

  static subscribeToNotification() {
    firebaseMessaging.subscribeToTopic('USER');
  }

  static initializeFCM() {
    initializeFirebaseMessaging();
    getToken();
    subscribeToNotification();
  }

  static sendPushNotificationToNearbyPartner(
      List<DriverModel> nearbyDrivers, String foodName) async {
    for (var deliveryPartner in nearbyDrivers) {
      try {
        final api = Uri.parse(APIS.pushNotificationAPI());
        var body = jsonEncode({
          "to": deliveryPartner.cloudMessagingToken,
          "notification": {
            "body": "New Delivery request for you",
            "title": "Delivery Request"
          },
          // "data": {"foodName": "Indomie"}
        });
        var headers = {
          'Content-Type': 'application/json',
          'Authorization': 'key=$fcmServerKey'
        };
        var response =
            await http.post(api, headers: headers, body: body).then((value) {
          log("Successfully sent the push notification");
        }).timeout(const Duration(seconds: 60), onTimeout: () {
          log("Connection timeout");
          throw TimeoutException("Connection timeout");
        }).onError((error, stackTrace) {
          log(error.toString());
          throw Exception(error);
        });
      } catch (error) {
        log(error.toString());
        throw Exception(error);
      }
    }
  }

  static sendPushNotificationToRestaurant(
      String fcmToken, String foodName) async {
    try {
      final api = Uri.parse(APIS.pushNotificationAPI());
      var body = jsonEncode({
        "to": fcmToken,
        "notification": {
          "body": "New Order for $foodName",
          "title": "Order for $foodName"
        },
        "data": {"foodName": "Indomie"}
      });
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'key=$fcmServerKey'
      };
      var response =
          await http.post(api, headers: headers, body: body).then((value) {
        log("Successfully sent the push notification");
      }).timeout(const Duration(seconds: 60), onTimeout: () {
        log("Connection timeout");
        throw TimeoutException("Connection timeout");
      }).onError((error, stackTrace) {
        log(error.toString());
        throw Exception(error);
      });
    } catch (error) {
      log(error.toString());
      throw Exception(error);
    }
  }
}





// rules_version = '2';

// service cloud.firestore {
//   match /databases/{database}/documents {

//     // This rule allows anyone with your Firestore database reference to view, edit,
//     // and delete all data in your Firestore database. It is useful for getting
//     // started, but it is configured to expire after 30 days because it
//     // leaves your app open to attackers. At that time, all client
//     // requests to your Firestore database will be denied.
//     //
//     // Make sure to write security rules for your app before that time, or else
//     // all client requests to your Firestore database will be denied until you Update
//     // your rules
//     match /{document=**} {
//       allow read, write: if request.time < timestamp.date(2024, 6, 6);
//     }
//   }
// }