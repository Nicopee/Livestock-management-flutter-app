// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cattle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************
Cattle _$CattleFromJson(Map<String, dynamic> json) {
  return Cattle(
    id: json['id'] as int,
    name: json['name'] as String,
    tagNo: json['tag_no'] as String,
    createdAt: json['created_at'] as String,
    weight: json['weight'] as int,
    dateOfBirth: json['date_of_birth'] as String,
    cattleImage: json['cattle_image'] as String,
    description: json['description'] as String,
    gender: json['gender'] as String,
  );
}

Map<String, dynamic> _$CattleToJson(Cattle instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tag_no': instance.tagNo,
      'created_at': instance.createdAt,
      'weight': instance.weight,
      'date_of_birth': instance.dateOfBirth,
      'cattle_image': instance.cattleImage,
      'description': instance.description,
      'gender': instance.gender,
    };
