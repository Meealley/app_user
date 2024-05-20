import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kfc/controller/services/fetch_restaurant_services.dart';
import 'package:kfc/model/food_model.dart';
import 'package:kfc/model/restaurant_model.dart';

class RestaurantProvider extends ChangeNotifier {
  List<RestaurantModel> restaurants = [];
  List<FoodModel> restaurantMenu = [];
  List<FoodModel> searchedFood = [];
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

  getRestaurantMenu(String restaurantID) {
    for (var data in foods) {
      if (data.restaurantUID == restaurantID) {
        restaurantMenu.add(data);
      }
    }
    notifyListeners();
  }

  emptyRestaurantMenu() {
    restaurantMenu = [];
    notifyListeners();
  }

  defaultSearchedFood() {
    searchedFood = foods;
    notifyListeners();
  }

  searchedFoodItems(String foodName) {
    for (var data in foods) {
      if (data.name.toLowerCase().contains(foodName.toLowerCase())) {
        searchedFood.add(data);
      }
    }
    notifyListeners();
  }
}
