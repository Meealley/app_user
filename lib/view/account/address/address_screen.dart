import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kfc/controller/provider/profile_provider.dart';
import 'package:kfc/model/user_address_model.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().fetchUserAddress();
    });
  }

  bool isAddedAddress = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Address"),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          children: [
            SizedBox(
              height: 2.h,
            ),
            Consumer<ProfileProvider>(
                builder: (context, profileProvider, child) {
              if (profileProvider.addresses.isEmpty) {
                return Center(
                    child: Text(
                  'Fetching Addresses...',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ));
              } else {
                List<UserAddressModel> addresses = profileProvider.addresses;
                return ListView.builder(
                  itemCount: addresses.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: ((context, index) {
                    UserAddressModel address = addresses[index];
                    return Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 1.5.h,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            5.sp,
                          ),
                          color: Colors.grey.shade300),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 1.h,
                                backgroundColor: address.isActive
                                    ? Colors.green
                                    : Colors.transparent,
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Text(address.addressTitle),
                            ],
                          ),
                          SizedBox(
                            height: 0.8.h,
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Room No : ",
                                style: TextStyle(
                                  color: Colors.black,
                                )),
                            TextSpan(
                                text: address.roomNum,
                                style: TextStyle(
                                  color: Colors.black,
                                ))
                          ])),
                          SizedBox(
                            height: 0.8.h,
                          ),
                          SizedBox(
                            height: 0.8.h,
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Apartment : ",
                                style: TextStyle(
                                  color: Colors.black,
                                )),
                            TextSpan(
                                text: address.apartment,
                                style: TextStyle(
                                  color: Colors.black,
                                ))
                          ])),
                          SizedBox(
                            height: 0.8.h,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.w, vertical: 1.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.sp),
                                  color: Colors.grey.shade100,
                                ),
                                child: Text("Set As Active"),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.w, vertical: 1.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.sp),
                                  color: Colors.grey.shade100,
                                ),
                                child: Text("Edit"),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.w, vertical: 1.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.sp),
                                  color: Colors.grey.shade100,
                                ),
                                child: Text("Delete"),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
                );
              }
            }),
            SizedBox(
              height: 4.h,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 13, 60, 14),
                  borderRadius: BorderRadius.circular(5.sp),
                ),
                child: isAddedAddress
                    ? const Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Center(
                        child: Text(
                          "Add Address",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
