import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DriverModel {
  String? name;
  String? profilePicUrl;
  String? mobileNumber;
  String? driverID;
  String? vehicleRegistrationNumber;
  String? driverLicenseNumber;
  DateTime? registeredDateTime;
  String? activeDeliveryRequestID;
  String? driverStatus;
  String? cloudMessagingToken;
  DriverModel({
    this.name,
    this.profilePicUrl,
    this.mobileNumber,
    this.driverID,
    this.vehicleRegistrationNumber,
    this.driverLicenseNumber,
    this.registeredDateTime,
    this.activeDeliveryRequestID,
    this.driverStatus,
    this.cloudMessagingToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'profilePicUrl': profilePicUrl,
      'mobileNumber': mobileNumber,
      'driverID': driverID,
      'vehicleRegistrationNumber': vehicleRegistrationNumber,
      'driverLicenseNumber': driverLicenseNumber,
      'registeredDateTime': registeredDateTime?.millisecondsSinceEpoch,
      'activeDeliveryRequestID': activeDeliveryRequestID,
      'driverStatus': driverStatus,
      'cloudMessagingToken': cloudMessagingToken,
    };
  }

  factory DriverModel.fromMap(Map<String, dynamic> map) {
    return DriverModel(
      name: map['name'] != null ? map['name'] as String : null,
      profilePicUrl:
          map['profilePicUrl'] != null ? map['profilePicUrl'] as String : null,
      mobileNumber:
          map['mobileNumber'] != null ? map['mobileNumber'] as String : null,
      driverID: map['driverID'] != null ? map['driverID'] as String : null,
      vehicleRegistrationNumber: map['vehicleRegistrationNumber'] != null
          ? map['vehicleRegistrationNumber'] as String
          : null,
      driverLicenseNumber: map['driverLicenseNumber'] != null
          ? map['driverLicenseNumber'] as String
          : null,
      registeredDateTime: map['registeredDateTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['registeredDateTime'] as int)
          : null,
      activeDeliveryRequestID: map['activeDeliveryRequestID'] != null
          ? map['activeDeliveryRequestID'] as String
          : null,
      driverStatus:
          map['driverStatus'] != null ? map['driverStatus'] as String : null,
      cloudMessagingToken: map['cloudMessagingToken'] != null
          ? map['cloudMessagingToken'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DriverModel.fromJson(String source) =>
      DriverModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
