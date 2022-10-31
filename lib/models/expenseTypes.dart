// To parse this JSON data, do
//
//     final expenseTypes = expenseTypesFromJson(jsonString);

import 'dart:convert';

ExpenseTypes expenseTypesFromJson(String str) =>
    ExpenseTypes.fromJson(json.decode(str));

String expenseTypesToJson(ExpenseTypes data) => json.encode(data.toJson());

class ExpenseTypes {
  ExpenseTypes({
    this.data,
  });

  List<Datum> data;

  factory ExpenseTypes.fromJson(Map<String, dynamic> json) => ExpenseTypes(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.expenseType,
    this.createdAt,
    this.updatedAt,
    this.addedBy,
  });

  int id;
  String expenseType;
  DateTime createdAt;
  DateTime updatedAt;
  int addedBy;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        expenseType: json["expense_type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        addedBy: json["added_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "expense_type": expenseType,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "added_by": addedBy,
      };
}
