// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kfc/controller/provider/profile_provider.dart';
import 'package:kfc/model/user_model.dart';
import 'package:kfc/view/account/address/address_screen.dart';
import 'package:kfc/view/account/widgets/account_list_model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AccountWidgets extends StatelessWidget {
  final String username;
  const AccountWidgets({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 2.w,
          vertical: 2.h,
        ),
        children: [
          Consumer<ProfileProvider>(builder: (context, profileProvider, child) {
            if (profileProvider.userData == null) {
              return Row(
                children: [
                  CircleAvatar(
                    radius: 3.h,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      radius: 3.h - 2,
                      child: FaIcon(
                        FontAwesomeIcons.user,
                        size: 3.h,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    username,
                    style: TextStyle(fontSize: 12.sp),
                  )
                ],
              );
            } else {
              UserModel userData = profileProvider.userData!;
              return Row(
                children: [
                  CircleAvatar(
                    radius: 3.h,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      radius: 3.h - 2,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(userData.profilePicsUrl),
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    userData.name,
                    style: TextStyle(fontSize: 12.sp),
                  )
                ],
              );
            }
          }),
          SizedBox(
            height: 3.h,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: accounts.length,
            itemBuilder: (context, index) {
              final userLists = accounts[index];

              return ListTile(
                onTap: () {
                  if (index == 1) {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: AddressScreen(),
                            type: PageTransitionType.rightToLeft));
                  }
                },
                leading: FaIcon(userLists.icon),
                title: Text(userLists.accountListName),
              );
            },
          ),
        ],
      ),
    );
  }
}
