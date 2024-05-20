import 'package:flutter/material.dart';
import 'package:kfc/controller/provider/restaurant_provider.dart';
import 'package:kfc/model/restaurant_model.dart';
import 'package:kfc/utils/vertical_card.dart';
import 'package:kfc/view/particularrestaurantmenuscreen/particular_restaurant_menu_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class NearbyRestarurant extends StatefulWidget {
  const NearbyRestarurant({super.key});

  @override
  State<NearbyRestarurant> createState() => _NearbyRestarurantState();
}

class _NearbyRestarurantState extends State<NearbyRestarurant> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, restaurantProvider, child) {
        if (restaurantProvider.restaurants.isEmpty) {
          return ListView.builder(
            itemCount: 10,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return const VerticalCard();
            },
          );
        } else {
          return ListView.builder(
            itemCount: restaurantProvider.restaurants.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              RestaurantModel restaurant =
                  restaurantProvider.restaurants[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        child: ParticularRestaurantmenu(
                          restaurantName: restaurant.restaurantName!,
                          restaurantUID: restaurant.restaurantUID!,
                        ),
                        type: PageTransitionType.rightToLeft),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.sp),
                      border: Border.all(
                        color: Colors.grey,
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 17.h,
                        width: 94.w,
                        margin: EdgeInsets.symmetric(vertical: 1.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.sp),
                          color: Colors.grey,
                          image: DecorationImage(
                            image: NetworkImage(
                              restaurant.bannerImages![0],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        restaurant.restaurantName!,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
