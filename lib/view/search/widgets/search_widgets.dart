import 'package:flutter/material.dart';
import 'package:kfc/controller/provider/restaurant_provider.dart';
import 'package:kfc/model/food_model.dart';
import 'package:kfc/view/fooddetails/food_details_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SearchWidgets extends StatelessWidget {
  final TextEditingController controller;
  // final bool isloading;
  const SearchWidgets({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(100.w, 12.h),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 3.w,
            vertical: 1.h,
          ),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.name,
            onChanged: (value) {
              context
                  .read<RestaurantProvider>()
                  .searchedFoodItems(value.trim());
            },
            decoration: InputDecoration(
              hintText: "Search for something...",
              contentPadding: EdgeInsets.symmetric(
                horizontal: 2.w,
                vertical: 0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  9.sp,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  9.sp,
                ),
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  9.sp,
                ),
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, restaurantProvider, child) {
          if (restaurantProvider.searchedFood.isEmpty) {
            return Center(
              child: Text("No Food Found"),
            );
          } else {
            return ListView.builder(
              itemCount: restaurantProvider.searchedFood.length,
              padding: EdgeInsets.symmetric(
                horizontal: 3.w,
                vertical: 2.h,
              ),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                FoodModel foodData = restaurantProvider.searchedFood[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          child: FoodDetailsScreen(
                            foodModel: foodData,
                          ),
                          type: PageTransitionType.rightToLeft),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 1.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.sp),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.sp),
                            image: DecorationImage(
                              image: NetworkImage(foodData.foodImageURL),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          foodData.name,
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Text(
                          foodData.description,
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              '\u20A6${foodData.discountedPrice}',
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
