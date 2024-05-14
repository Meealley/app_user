import 'dart:html';

import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kfc/controller/services/location_services.dart';

class RestaurantServices {
  static getNearbyRestaurant() async {
    Geofire.initialize("Restaurants");
    Position currentPosition = await LocationServices.getCurrentLocation();
    Geofire.queryAtLocation(
      currentPosition.latitude,
      currentPosition.longitude,
      40, //Change back to 20;
    );
  }
}
