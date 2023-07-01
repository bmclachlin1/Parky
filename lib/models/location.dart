class Location {
  final String documentId;
  final String name;
  final List<double> latLong;

  Location({
    required this.documentId,
    required this.name,
    required this.latLong,
  }) : assert(latLong.length == 2);

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        documentId: json['id'], name: json['name'], latLong: json['latLong']);
  }

  Map<String, dynamic> toJson() =>
      {'id': documentId, 'name': name, 'latLong': latLong};

  @override
  String toString() {
    return toJson().toString();
  }
}
