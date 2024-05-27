import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kfc/controller/provider/profile_provider.dart';
import 'package:kfc/utils/custom_button.dart';
import 'package:kfc/utils/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class UserRegistrationWidgets extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController houseNumController;
  final TextEditingController apartmentController;
  final TextEditingController savedAddressAsController;
  final VoidCallback onTapped;
  final bool isRegisteredPressed;
  final CameraPosition initialCameraPosition;
  final void Function(GoogleMapController)? onMapCreated;

  final VoidCallback onTapProfileImage;
  const UserRegistrationWidgets(
      {super.key,
      required this.onTapProfileImage,
      required this.nameController,
      required this.initialCameraPosition,
      required this.onMapCreated,
      required this.houseNumController,
      required this.apartmentController,
      required this.savedAddressAsController,
      required this.onTapped,
      required this.isRegisteredPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
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
          Consumer<ProfileProvider>(
            builder: (context, profileProvider, child) {
              return GestureDetector(
                onTap: onTapProfileImage,
                child: CircleAvatar(
                  radius: 5.h,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 5.h - 2,
                      child: profileProvider.profileImage == null
                          ? FaIcon(
                              FontAwesomeIcons.person,
                              size: 4.h,
                              color: Colors.black,
                            )
                          : Image(
                              height: 7.6.h,
                              width: 16.w,
                              image: FileImage(profileProvider.profileImage!),
                              fit: BoxFit.contain,
                            )),
                ),
              );
            },
          ),
          SizedBox(
            height: 4.h,
          ),
          CustomTextField(
            title: 'Name',
            controller: nameController,
            hintText: "Enter your Name",
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: 2.h,
          ),
          Text("Address"),
          SizedBox(
            height: 2.h,
          ),
          SizedBox(
            height: 40.h,
            width: 100.w,
            child: GoogleMap(
              initialCameraPosition: initialCameraPosition,
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              onMapCreated: onMapCreated,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          CustomTextField(
            title: "House Number",
            controller: houseNumController,
            hintText: "House/ Flat/ Block no",
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: 2.h,
          ),
          CustomTextField(
            title: "Apartment",
            controller: apartmentController,
            hintText: "Enter your House Number",
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: 2.h,
          ),
          CustomTextField(
            title: "Save Address As",
            controller: savedAddressAsController,
            hintText: "Home/ Work/ School",
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: 3.h,
          ),
          GestureDetector(
            onTap: onTapped,
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 13, 60, 14),
                borderRadius: BorderRadius.circular(5.sp),
              ),
              child: isRegisteredPressed
                  ? const Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : const Center(
                      child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )),
            ),
          ),
        ],
      ),
    );
  }
}
