import 'package:flutter/material.dart';
import 'package:kfc/model/food_model.dart';
import 'package:kfc/view/fooddetails/widgets/food_details_widget.dart';

class FoodDetailsScreen extends StatefulWidget {
  final FoodModel foodModel;
  const FoodDetailsScreen({super.key, required this.foodModel});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int _quantity = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _quantity = 0;
      });
    });
  }

  void _onTappedMinus() {
    if (_quantity > 0) {
      setState(() {
        _quantity -= 1;
      });
    }
  }

  void _onTappedPlus() {
    setState(() {
      _quantity += 1;
    });
  }

  void _onTapped() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FoodDetailsWidget(
        quantity: _quantity,
        onTappedMinus: _onTappedMinus,
        onTappedPlus: _onTappedPlus,
        onTapped: _onTapped,
        foodModel: widget.foodModel,
      ),
    );
  }
}
