import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kfc/constants/constants.dart';
import 'package:kfc/controller/provider/profile_provider.dart';
import 'package:kfc/controller/services/image_services.dart';
import 'package:kfc/controller/services/location_services.dart';
import 'package:kfc/controller/services/toast_message_services.dart';
import 'package:kfc/controller/services/user_data_crud_services.dart';
// import 'package:kfc/model/address_model.dart';
import 'package:kfc/model/user_address_model.dart';
import 'package:kfc/model/user_model.dart';
import 'package:kfc/view/account/address/add_address_widgets.dart';
import 'package:kfc/view/userregistrationscreen/widgets/user_reg_widgets.dart';
import 'package:provider/provider.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _housenumController = TextEditingController();
  final TextEditingController _apartmentController = TextEditingController();
  final TextEditingController _savedAddressAsController =
      TextEditingController();

  CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(6.5244, 3.3792),
    zoom: 14,
  );
  Completer<GoogleMapController> googleMapContoller = Completer();
  GoogleMapController? mapController;
  bool _registerButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: AddAddressWidgets(
      initialCameraPosition: initialCameraPosition,
      onMapCreated: (GoogleMapController controller) async {
        googleMapContoller.complete(controller);
        mapController = controller;
        Position currPostion = await LocationServices.getCurrentLocation();
        LatLng currLatLng = LatLng(
          currPostion.latitude,
          currPostion.longitude,
        );
        CameraPosition cameraPosition = CameraPosition(
          target: currLatLng,
          zoom: 14,
        );
        mapController!
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      },
      nameController: _nameController,
      houseNumController: _housenumController,
      apartmentController: _apartmentController,
      savedAddressAsController: _savedAddressAsController,
      onTapped: () async {
        setState(() {
          _registerButtonPressed = true;
        });

        Position location = await LocationServices.getCurrentLocation();
        String addressID = uuid.v1().toString();

        UserAddressModel addressData = UserAddressModel(
          addressID: addressID,
          userID: auth.currentUser!.uid,
          latitude: location.latitude,
          longitude: location.longitude,
          roomNum: _housenumController.text.trim(),
          apartment: _apartmentController.text.trim(),
          addressTitle: _savedAddressAsController.text.trim(),
          uploadTime: DateTime.now(),
          isActive: false,
        );

        // ignore: use_build_context_synchronously
        await UserDataCRUDServices.addAddress(addressData, context);
        Navigator.pop(context);
        context.read<ProfileProvider>().fetchUserAddress();
        ToastService.sendScaffoldAlert(
          context: context,
          msg: "Added New Address",
          toastStatus: "SUCCESS",
        );
        log("Address Added successfully!");
      },
      isRegisteredPressed: _registerButtonPressed,
      onTapProfileImage: () async {
        await context.read<ProfileProvider>().pickFoodImageFromGallery(context);
      },
    ));
  }
}
