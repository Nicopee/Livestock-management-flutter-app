// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
part 'feed.g.dart';

@JsonSerializable()
class Feed {
  int id;
  String name;
  String description;
  @JsonKey(name: 'created_at')
  String createdAt;

  Feed({
    this.id,
    this.name,
    this.description,
    this.createdAt,
  });
  Map toJson() {
    return _$FeedToJson(this);
  }

  factory Feed.fromJson(Map<String, dynamic> json) {
    return _$FeedFromJson(json);
  }
}
