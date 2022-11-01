// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Version _$VersionFromJson(Map<String, dynamic> json) {
  return Version(
    version: json['version'] as String,
    buildNumber: json['build_number'] as int,
    isForced: json['isForced'] as bool,
    minimumSupported: json['minimum_supported'] as int,
  );
}

Map<String, dynamic> _$VersionToJson(Version instance) => <String, dynamic>{
      'version': instance.version,
      'build_number': instance.buildNumber,
      'isForced': instance.isForced,
      'minimum_supported': instance.minimumSupported,
    };
