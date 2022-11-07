// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Analytics _$AnalyticsFromJson(Map<String, dynamic> json) {
  return Analytics(
    totalIncomeAmount: json['total_income_amount'] as String,
    totalExpenseAmount: json['total_expense_amount'] as String,
  );
}

Map<String, dynamic> _$AnalyticsToJson(Analytics instance) => <String, dynamic>{
      'total_income_amount': instance.totalIncomeAmount,
      'total_expense_amount': instance.totalExpenseAmount,
    };
