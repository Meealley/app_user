import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kfc/controller/services/fetch_restaurant_services.dart';
import 'package:kfc/model/food_model.dart';
import 'package:kfc/model/restaurant_model.dart';

class RestaurantProvider extends ChangeNotifier {
  List<RestaurantModel> restaurants = [];

  List<FoodModel> foods = [];

  addRestaurants(String restaurantID) async {
    RestaurantModel data =
        await RestaurantServices.fetchRestaurantData(restaurantID);
    restaurants.add(data);
    notifyListeners();
    log("Total Restaurants fetched");
    log(restaurants.length.toString());
  }

  addFoods(String restaurantID) async {
    List<FoodModel> foodData =
        await RestaurantServices.fetchFoodData(restaurantID);
    foods.addAll(foodData);
    notifyListeners();
    log("Total Food items fetched");
    log(foods.length.toString());
  }
}
