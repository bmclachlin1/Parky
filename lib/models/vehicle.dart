import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
  final String documentId;
  final String make;
  final String model;
  final int year;
  final String userId;
  final String userDisplayName;
  final Timestamp checkInDate;
  final Timestamp? checkOutDate;

  Vehicle(
      {required this.documentId,
      required this.make,
      required this.model,
      required this.year,
      required this.userId,
      required this.userDisplayName,
      required this.checkInDate,
      this.checkOutDate});

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
        documentId: json['id'],
        make: json['make'],
        model: json['model'],
        year: json['year'],
        userId: json['userId'],
        userDisplayName: json['userDisplayName'],
        checkInDate: json['checkInDate'],
        checkOutDate: json['checkOutDate']);
  }

  Map<String, dynamic> toJson() => {
        'id': documentId,
        'make': make,
        'model': model,
        'year': year,
        'userId': userId,
        'userDisplayName': userDisplayName,
        'checkInDate': checkInDate,
        'checkOutDate': checkOutDate
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
