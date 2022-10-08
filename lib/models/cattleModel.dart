// To parse this JSON data, do
//
//     final cattleModel = cattleModelFromJson(jsonString);

import 'dart:convert';

CattleModel cattleModelFromJson(String str) =>
    CattleModel.fromJson(json.decode(str));

String cattleModelToJson(CattleModel data) => json.encode(data.toJson());

class CattleModel {
  CattleModel({
    required this.data,
  });

  List<Datum> data;

  factory CattleModel.fromJson(Map<String, dynamic> json) => CattleModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.tagNo,
    required this.weight,
    required this.dateOfBirth,
    required this.cattleImage,
    required this.description,
    required this.gender,
    required this.cattleBreedId,
    required this.createdAt,
    required this.updatedAt,
    required this.age,
    required this.breed,
  });

  int id;
  String name;
  String tagNo;
  String weight;
  DateTime dateOfBirth;
  String cattleImage;
  String description;
  String gender;
  int cattleBreedId;
  DateTime createdAt;
  DateTime updatedAt;
  int age;
  Breed breed;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        tagNo: json["tag_no"],
        weight: json["weight"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        cattleImage: json["cattle_image"],
        description: json["description"],
        gender: json["gender"],
        cattleBreedId: json["cattle_breed_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        age: json["age"],
        breed: Breed.fromJson(json["breed"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tag_no": tagNo,
        "weight": weight,
        "date_of_birth": dateOfBirth.toIso8601String(),
        "cattle_image": cattleImage,
        "description": description,
        "gender": gender,
        "cattle_breed_id": cattleBreedId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "age": age,
        "breed": breed.toJson(),
      };
}

class Breed {
  Breed({
    required this.id,
    required this.breed,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String breed;
  DateTime createdAt;
  DateTime updatedAt;

  factory Breed.fromJson(Map<String, dynamic> json) => Breed(
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
