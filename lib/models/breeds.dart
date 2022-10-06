// To parse this JSON data, do
//
//     final breeds = breedsFromJson(jsonString);

import 'dart:convert';

Breeds breedsFromJson(String str) => Breeds.fromJson(json.decode(str));

String breedsToJson(Breeds data) => json.encode(data.toJson());

class Breeds {
  Breeds({
    required this.data,
  });

  List<Datum> data;

  factory Breeds.fromJson(Map<String, dynamic> json) => Breeds(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.breed,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String breed;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        breed: json["breed"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "breed": breed,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
