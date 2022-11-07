import 'package:json_annotation/json_annotation.dart';
part 'analytics.g.dart';

@JsonSerializable()
class Analytics {
  @JsonKey(name: 'total_income_amount')
  String totalIncomeAmount;
  @JsonKey(name: 'total_expense_amount')
  String totalExpenseAmount;
  Analytics({this.totalIncomeAmount, this.totalExpenseAmount});

  Map toJson() {
    return _$AnalyticsToJson(this);
  }

  factory Analytics.fromJson(Map<String, dynamic> json) {
    return _$AnalyticsFromJson(json);
  }
}
