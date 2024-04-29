import 'package:flutter/material.dart';
import 'package:kfc/view/featured/widgets/featured_widgets.dart';

class FeaturedScreen extends StatefulWidget {
  const FeaturedScreen({super.key});

  @override
  State<FeaturedScreen> createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  @override
  Widget build(BuildContext context) {
    return FeaturedWidgets();
  }
}
