// To parse this JSON data, do
//
//     final milkModel = milkModelFromJson(jsonString);

import 'dart:convert';

MilkModel milkModelFromJson(String str) => MilkModel.fromJson(json.decode(str));

String milkModelToJson(MilkModel data) => json.encode(data.toJson());

class MilkModel {
  MilkModel({
    this.data,
  });

  List<Datum> data;

  factory MilkModel.fromJson(Map<String, dynamic> json) => MilkModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.milkingDate,
    this.totalMilk,
    this.description,
    this.cattleId,
    this.createdAt,
    this.updatedAt,
    this.cattle,
  });

  int id;
  DateTime milkingDate;
  int totalMilk;
  String description;
  int cattleId;
  DateTime createdAt;
  DateTime updatedAt;
  Cattle cattle;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        milkingDate: DateTime.parse(json["milking_date"]),
        totalMilk: json["total_milk"],
        description: json["description"],
        cattleId: json["cattle_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        cattle: Cattle.fromJson(json["cattle"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "milking_date": milkingDate.toIso8601String(),
        "total_milk": totalMilk,
        "description": description,
        "cattle_id": cattleId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "cattle": cattle.toJson(),
      };
}

class Cattle {
  Cattle({
    this.id,
    this.name,
    this.tagNo,
    this.weight,
    this.dateOfBirth,
    this.cattleImage,
    this.description,
    this.gender,
    this.cattleBreedId,
    this.createdAt,
    this.updatedAt,
    this.age,
    this.breed,
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

  factory Cattle.fromJson(Map<String, dynamic> json) => Cattle(
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
    this.id,
    this.breed,
    this.createdAt,
    this.updatedAt,
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
