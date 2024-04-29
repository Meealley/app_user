import 'package:flutter/material.dart';
import 'package:kfc/view/bottomnavigationbar/bottom_navigationbar_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const KFCApp());
}

class KFCApp extends StatelessWidget {
  const KFCApp({super.key});

  final title = "KFC App";

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, _, __) {
      return MaterialApp(
        title: title,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Manrope",
        ),
        home: const BottomNavigationUser(),
      );
    });
  }
}
