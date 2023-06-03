import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
  final String make;
  final String model;
  final int year;
  final String userId;
  final String userDisplayName;
  final Timestamp checkInDate;
  final Timestamp checkOutDate;

  Vehicle(
      {required this.make,
      required this.model,
      required this.year,
      required this.userId,
      required this.userDisplayName,
      required this.checkInDate,
      required this.checkOutDate});

  // factory Vehicle.fromJson(Map<String, Object> json) {
  //   return Vehicle(make: json['make']);
  // }
}
