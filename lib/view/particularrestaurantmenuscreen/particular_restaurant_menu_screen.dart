import 'package:flutter/material.dart';
import 'package:kfc/controller/provider/restaurant_provider.dart';
import 'package:kfc/model/food_model.dart';
import 'package:kfc/view/fooddetails/food_details_screen.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:kfc/view/particularrestaurantmenuscreen/widgets/p_r_m_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ParticularRestaurantmenu extends StatefulWidget {
  final String restaurantUID;
  final String restaurantName;
  const ParticularRestaurantmenu(
      {super.key, required this.restaurantUID, required this.restaurantName});

  @override
  State<ParticularRestaurantmenu> createState() =>
      _ParticularRestaurantmenuState();
}

class _ParticularRestaurantmenuState extends State<ParticularRestaurantmenu> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RestaurantProvider>().emptyRestaurantMenu();
      context
          .read<RestaurantProvider>()
          .getRestaurantMenu(widget.restaurantUID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.restaurantName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Consumer<RestaurantProvider>(
          builder: (context, restaurantProvider, child) {
            if (restaurantProvider.restaurantMenu.isEmpty) {
              return Center(
                child: Text("Fetching food items..."),
              );
            } else {
              return ListView.builder(
                itemCount: restaurantProvider.restaurantMenu.length,
                padding: EdgeInsets.symmetric(
                  horizontal: 3.w,
                  vertical: 2.h,
                ),
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  FoodModel foodData = restaurantProvider.restaurantMenu[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: FoodDetailsScreen(
                            foodModel: foodData,
                          ),
                          type: PageTransitionType.rightToLeft,
                        ),
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
                                '\u20A6${foodData.price}',
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
      ),
    );
  }
}
