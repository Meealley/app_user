import 'package:flutter/material.dart';
import 'package:kfc/view/featured/widgets/featured_card.dart';
import 'package:sizer/sizer.dart';

class FeaturedWidgets extends StatelessWidget {
  const FeaturedWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 15.h,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return HorizontalCard(
                restuarantName: "Tastess",
                restaurantImage: "assets/images/displayImg.jpeg",
                price: "3,000",
                status: "Closed",
                rating: 4.7,
                noOfratings: 1200,
              );
            }),
      ),
    );
  }
}
