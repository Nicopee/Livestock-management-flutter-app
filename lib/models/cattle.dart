// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
part 'cattle.g.dart';

// part 'user.dart';

@JsonSerializable()
class Cattle {
  int id;
  String name;
  @JsonKey(name: 'tag_no')
  String tagNo;
  String weight;
  @JsonKey(name: 'date_of_birth')
  String dateOfBirth;
  @JsonKey(name: 'cattle_image')
  String cattleImage;
  String description;
  String gender;
  @JsonKey(name: 'created_at')
  String createdAt;

  Cattle({
    this.id,
    this.name,
    this.tagNo,
    this.weight,
    this.dateOfBirth,
    this.cattleImage,
    this.description,
    this.gender,
    this.createdAt,
  });

  factory Cattle.fromJson(Map<String, dynamic> json) {
    return _$CattleFromJson(json);
  }

  Map toJson() {
    return _$CattleToJson(this);
  }
}
