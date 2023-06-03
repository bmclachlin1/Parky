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

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
        make: json['make'],
        model: json['model'],
        year: json['year'],
        userId: json['userId'],
        userDisplayName: json['userDisplayName'],
        checkInDate: json['checkInDate'],
        checkOutDate: json['checkOutDate']);
  }
}
