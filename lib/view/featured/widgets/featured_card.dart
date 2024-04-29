import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class HorizontalCard extends StatelessWidget {
  final String restuarantName;
  final String restaurantImage;
  final String price;
  final String status;
  final double rating;
  final double noOfratings;
  const HorizontalCard({
    Key? key,
    required this.restuarantName,
    required this.restaurantImage,
    required this.price,
    required this.status,
    required this.rating,
    required this.noOfratings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      height: 100,
      width: 300,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.sp),
            child: Image.asset(
              restaurantImage,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(restuarantName),
              FaIcon(
                FontAwesomeIcons.heart,
              )
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.motorcycle,
                    size: 13,
                  ),
                  Text(
                    " From \$$price ",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  Text("| "),
                  Text(status),
                ],
              ),
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.star,
                    size: 17,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(rating.toString()),
                  Text("(${noOfratings.toString()})")
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
