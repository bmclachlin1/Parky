import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Vehicle extends Equatable {
  final String documentId;
  final String locationId;
  final String make;
  final String model;
  final int year;
  final String userId;
  final String userDisplayName;
  final Timestamp checkInDate;
  final Timestamp? checkOutDate;

  Vehicle(
      {required this.documentId,
      required this.locationId,
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
        locationId: json['locationId'],
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
        'locationId': locationId,
        'make': make,
        'model': model,
        'year': year,
        'userId': userId,
        'userDisplayName': userDisplayName,
        'checkInDate': checkInDate,
        'checkOutDate': checkOutDate
      };

  @override
  List<Object?> get props => [
        documentId,
        locationId,
        make,
        model,
        year,
        userId,
        userDisplayName,
        checkInDate,
        checkOutDate
      ];

  @override
  String toString() {
    return toJson().toString();
  }
}
