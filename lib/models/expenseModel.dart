// To parse this JSON data, do
//
//     final expenseModel = expenseModelFromJson(jsonString);

import 'dart:convert';

ExpenseModel expenseModelFromJson(String str) =>
    ExpenseModel.fromJson(json.decode(str));

String expenseModelToJson(ExpenseModel data) => json.encode(data.toJson());

class ExpenseModel {
  ExpenseModel({
    required this.data,
  });

  List<Datum> data;

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.expenseDate,
    required this.amountSpent,
    required this.receiptNo,
    required this.description,
    required this.expenseTypeId,
    required this.addedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.expenseTypes,
  });

  int id;
  DateTime expenseDate;
  int amountSpent;
  dynamic receiptNo;
  String description;
  int expenseTypeId;
  int addedBy;
  DateTime createdAt;
  DateTime updatedAt;
  ExpenseTypes expenseTypes;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        expenseDate: DateTime.parse(json["expense_date"]),
        amountSpent: json["amount_spent"],
        receiptNo: json["receipt_no"],
        description: json["description"],
        expenseTypeId: json["expense_type_id"],
        addedBy: json["added_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        expenseTypes: ExpenseTypes.fromJson(json["expense_types"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "expense_date": expenseDate.toIso8601String(),
        "amount_spent": amountSpent,
        "receipt_no": receiptNo,
        "description": description,
        "expense_type_id": expenseTypeId,
        "added_by": addedBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "expense_types": expenseTypes.toJson(),
      };
}

class ExpenseTypes {
  ExpenseTypes({
    required this.id,
    required this.expenseType,
    required this.createdAt,
    required this.updatedAt,
    required this.addedBy,
  });

  int id;
  String expenseType;
  DateTime createdAt;
  DateTime updatedAt;
  int addedBy;

  factory ExpenseTypes.fromJson(Map<String, dynamic> json) => ExpenseTypes(
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
