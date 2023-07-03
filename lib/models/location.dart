import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String documentId;
  final String name;
  final List<dynamic> latlong;

  const Location({
    required this.documentId,
    required this.name,
    required this.latlong,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        documentId: json['id'], name: json['name'], latlong: json['latlong']);
  }

  Map<String, dynamic> toJson() =>
      {'id': documentId, 'name': name, 'latlong': latlong};

  @override
  List<Object> get props => [documentId, name, latlong];

  @override
  String toString() {
    return toJson().toString();
  }
}
