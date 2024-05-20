import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SearchWidgets extends StatelessWidget {
  final TextEditingController controller;
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
            keyboardType: TextInputType.phone,
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
      body: Center(
        child: Text("Search screen"),
      ),
    );
  }
}
