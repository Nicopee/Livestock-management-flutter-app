// To parse this JSON data, do
//
//     final incomes = incomesFromJson(jsonString);

import 'dart:convert';

Incomes incomesFromJson(String str) => Incomes.fromJson(json.decode(str));

String incomesToJson(Incomes data) => json.encode(data.toJson());

class Incomes {
  Incomes({
    this.data,
  });

  List<Datum> data;

  factory Incomes.fromJson(Map<String, dynamic> json) => Incomes(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.incomeType,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String incomeType;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        incomeType: json["income_type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "income_type": incomeType,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
