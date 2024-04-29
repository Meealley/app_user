
import 'package:flutter/material.dart';
import 'package:kfc/utils/custom_button.dart';
import 'package:kfc/utils/reusable_text.dart';
import 'package:sizer/sizer.dart';

class LoginScreenWidget extends StatelessWidget {
  final String text;
  final String selectedCountry;
  final VoidCallback onTapCountry;
  final VoidCallback onPressed;
  final VoidCallback onPressNext;
  final TextEditingController controller;

  const LoginScreenWidget(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.onTapCountry,
      required this.selectedCountry,
      required this.onPressNext,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 3.w,
          vertical: 7.h,
        ),
        children: [
          SizedBox(
            height: 2.h,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onTapCountry,
                child: Container(
                  height: 5.5.h,
                  width: 20.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(
                      8.sp,
                    ),
                  ),
                  child: Text(
                    selectedCountry,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
              ),
              SizedBox(
                width: 70.w,
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Enter phone number",
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
              )
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          // ElevatedButton(
          //   onPressed: onPressed,
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.black,
          //     foregroundColor: Colors.white,
          //     minimumSize: Size(90.w, 6.h),
          //   ),
          //   child: Stack(
          //     children: [
          //       Align(
          //         alignment: Alignment.center,
          //         child: Text(
          //           "Next",
          //           style: TextStyle(
          //             fontSize: 12.sp,
          //           ),
          //         ),
          //       ),
          //       Positioned(
          //         right: 5.w,
          //         child: const Icon(Icons.forward),
          //       )
          //     ],
          //   ),
          // ),
          CustomButton(
            text: "Next",
            onTapped: onPressed,
          ),
          SizedBox(
            height: 2.h,
          ),
          const ReusableText(
            text:
                "By proceeding, you consent to get call and emails if necessary",
            color: Colors.grey,
          ),
          SizedBox(
            height: 3.h,
          ),
          // TextButton(
          //   onPressed: onPressNext,
          //   style: TextButton.styleFrom(
          //     backgroundColor: Colors.red,
          //     minimumSize: Size(90.w, 6.h),
          //   ),
          //   child: Stack(
          //     children: [
          //       Align(
          //         alignment: Alignment.center,
          //         child: Text(
          //           "Continue with Google",
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 12.sp,
          //           ),
          //         ),
          //       ),
          //       Positioned(
          //         left: 4.w,
          //         child: FaIcon(
          //           FontAwesomeIcons.google,
          //           color: Colors.white,
          //           size: 2.h,
          //         ),
          //       )
          //     ],
          //   ),
          // )
          CustomButton(
            text: "Continue with Google",
            onTapped: onPressNext,
          )
        ],
      ),
    );
  }
}
