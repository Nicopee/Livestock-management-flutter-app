import 'package:json_annotation/json_annotation.dart';
part 'access_token.g.dart';

@JsonSerializable()
class AccessToken {
  @JsonKey(name: 'access_token')
  String accessToken;
  @JsonKey(name: 'refresh_token')
  String refreshToken;
  @JsonKey(name: 'expires_in')
  int expiresIn;
  AccessToken({this.accessToken, this.refreshToken, this.expiresIn});

  Map toJson() {
    return _$AccessTokenToJson(this);
  }

  factory AccessToken.fromJson(Map<String, dynamic> json) {
    return _$AccessTokenFromJson(json);
  }
}
