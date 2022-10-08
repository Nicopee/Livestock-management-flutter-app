// To parse this JSON data, do
//
//     final inseminationModel = inseminationModelFromJson(jsonString);

import 'dart:convert';

InseminationModel inseminationModelFromJson(String str) =>
    InseminationModel.fromJson(json.decode(str));

String inseminationModelToJson(InseminationModel data) =>
    json.encode(data.toJson());

class InseminationModel {
  InseminationModel({
    required this.data,
  });

  List<Datum> data;

  factory InseminationModel.fromJson(Map<String, dynamic> json) =>
      InseminationModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.inseminationDate,
    required this.description,
    required this.cattleId,
    required this.createdAt,
    required this.updatedAt,
    required this.expectedBirth,
    required this.cattle,
  });

  int id;
  DateTime inseminationDate;
  String description;
  int cattleId;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime expectedBirth;
  Cattle cattle;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        inseminationDate: DateTime.parse(json["insemination_date"]),
        description: json["description"],
        cattleId: json["cattle_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        expectedBirth: DateTime.parse(json["expected_birth"]),
        cattle: Cattle.fromJson(json["cattle"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "insemination_date": inseminationDate.toIso8601String(),
        "description": description,
        "cattle_id": cattleId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "expected_birth": expectedBirth.toIso8601String(),
        "cattle": cattle.toJson(),
      };
}

class Cattle {
  Cattle({
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
      };
}
