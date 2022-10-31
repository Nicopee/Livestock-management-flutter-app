// To parse this JSON data, do
//
//     final incomeModel = incomeModelFromJson(jsonString);

import 'dart:convert';

IncomeModel incomeModelFromJson(String str) =>
    IncomeModel.fromJson(json.decode(str));

String incomeModelToJson(IncomeModel data) => json.encode(data.toJson());

class IncomeModel {
  IncomeModel({
    this.data,
  });

  List<Datum> data;

  factory IncomeModel.fromJson(Map<String, dynamic> json) => IncomeModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.incomeDate,
    this.amountEarned,
    this.receiptNo,
    this.description,
    this.incomeTypeId,
    this.createdAt,
    this.updatedAt,
    this.incomeTypes,
  });

  int id;
  DateTime incomeDate;
  int amountEarned;
  dynamic receiptNo;
  String description;
  int incomeTypeId;
  DateTime createdAt;
  DateTime updatedAt;
  IncomeTypes incomeTypes;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        incomeDate: DateTime.parse(json["income_date"]),
        amountEarned: json["amount_earned"],
        receiptNo: json["receipt_no"],
        description: json["description"],
        incomeTypeId: json["income_type_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        incomeTypes: IncomeTypes.fromJson(json["income_types"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "income_date": incomeDate.toIso8601String(),
        "amount_earned": amountEarned,
        "receipt_no": receiptNo,
        "description": description,
        "income_type_id": incomeTypeId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "income_types": incomeTypes.toJson(),
      };
}

class IncomeTypes {
  IncomeTypes({
    this.id,
    this.incomeType,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String incomeType;
  DateTime createdAt;
  DateTime updatedAt;

  factory IncomeTypes.fromJson(Map<String, dynamic> json) => IncomeTypes(
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
