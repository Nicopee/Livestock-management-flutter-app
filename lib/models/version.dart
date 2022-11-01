import 'package:json_annotation/json_annotation.dart';

part 'version.g.dart';

@JsonSerializable()
class Version {
  String version;
  @JsonKey(name: 'build_number')
  int buildNumber;
  bool isForced;
  @JsonKey(name: 'minimum_supported')
  int minimumSupported;
  Version({
    this.version,
    this.buildNumber,
    this.isForced,
    this.minimumSupported,
  });

  factory Version.fromJson(Map<String, dynamic> map) {
    return _$VersionFromJson(map);
  }
  Map<String, dynamic> toJson() {
    return _$VersionToJson(this);
  }
}
