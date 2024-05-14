import 'dart:developer';
// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kfc/constants/constants.dart';
import 'package:kfc/controller/provider/restaurant_provider.dart';
import 'package:kfc/controller/services/location_services.dart';
import 'package:kfc/model/food_model.dart';
import 'package:kfc/model/restaurant_id_n_location_model.dart';
import 'package:kfc/model/restaurant_model.dart';
import 'package:provider/provider.dart';

class RestaurantServices {
  static getNearbyRestaurant(BuildContext context) async {
    Geofire.initialize("Restaurants");
    Position currentPosition = await LocationServices.getCurrentLocation();
    Geofire.queryAtLocation(
      currentPosition.latitude,
      currentPosition.longitude,
      40, //Change back to 20;
    )!
        .listen((event) {
      if (event != null) {
        log("Event is not null");
        var callback = event['callBack'];
        switch (callback) {
          case Geofire.onKeyEntered:
            log("Key Entered");
            RestaurantIDnLocationModel model = RestaurantIDnLocationModel(
                id: event['key'],
                latitude: event['latitude'],
                longitude: event['longitude']);
            log("Restaurant Data is");
            log(model.toJson().toString());
            log('\n\n\n');
            context.read<RestaurantProvider>().addRestaurants(model.id);
            context.read<RestaurantProvider>().addFoods(model.id);
            break;

          case Geofire.onGeoQueryReady:
            // RestaurantIDnLocationModel model = RestaurantIDnLocationModel(
            //     id: event['key'],
            //     latitude: event['latitude'],
            //     longitude: event['longitude']);
            log('Query Ready');

            break;
        }
      }
    });
  }

  static fetchRestaurantData(String restaurantID) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('Restaurant').doc(restaurantID).get();

      RestaurantModel data = RestaurantModel.fromMap(snapshot.data()!);
      return data;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static fetchFoodData(String restaurantID) async {
    List<FoodModel> foodData = [];

    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('Food')
          .orderBy('uploadTime', descending: true)
          .where('restaurantUID', isEqualTo: restaurantID)
          .get();
      snapshot.docs.forEach((element) {
        foodData.add(FoodModel.fromMap(element.data()));
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
    return foodData;
  }
}
