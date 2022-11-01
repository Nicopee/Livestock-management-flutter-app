// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  int id;
  @JsonKey(name: 'firstname')
  String firstName;
  @JsonKey(name: 'lastname')
  String lastName;
  String email;
  @JsonKey(name: 'phone_contact')
  String phoneContact;
  String role;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.role,
    this.phoneContact,
  });
  Map toJson() {
    return _$UserToJson(this);
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }
}
