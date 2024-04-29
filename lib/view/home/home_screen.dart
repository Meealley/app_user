import 'package:flutter/material.dart';
import 'package:kfc/view/home/widgets/home_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: HomeWidgets(
      location: "Current Location ... ",
    ));
  }
}
