import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kfc/model/food_model.dart';
import 'package:kfc/utils/custom_button.dart';
import 'package:sizer/sizer.dart';

class FoodDetailsWidget extends StatelessWidget {
  final FoodModel foodModel;
  final int quantity;
  final VoidCallback onTappedMinus;
  final VoidCallback onTappedPlus;
  final VoidCallback onTapped;
  const FoodDetailsWidget(
      {super.key,
      required this.foodModel,
      required this.onTappedMinus,
      required this.quantity,
      required this.onTappedPlus,
      required this.onTapped});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(foodModel.name),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 3.w,
          vertical: 2.h,
        ),
        children: [
          SizedBox(
            height: 2.h,
          ),
          SizedBox(
            height: 23.h,
            width: 100.w,
            child: Image(
              image: NetworkImage(foodModel.foodImageURL),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            foodModel.name,
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            foodModel.description,
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.grey,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: onTappedMinus,
                    child: Container(
                      height: 3.h,
                      width: 3.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.sp),
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.minus,
                        size: 2.h,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    '\t $quantity \t',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: onTappedPlus,
                    child: Container(
                      height: 3.h,
                      width: 3.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.sp),
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.plus,
                        size: 2.h,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                " \u20A6 ${foodModel.price}",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                ),
              )
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          CustomButton(
            onTapped: onTapped,
            text: 'Add to Cart',
          ),
          SizedBox(
            height: 2.h,
          ),
          CustomButton(
            onTapped: onTapped,
            text: 'Order now',
          ),
        ],
      ),
    );
  }
}
