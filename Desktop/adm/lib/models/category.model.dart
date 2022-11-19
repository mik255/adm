
import 'package:json_annotation/json_annotation.dart';

import 'story.model.dart';

part 'category.model.g.dart';

@JsonSerializable()
class Category {
  int id;
  String name;
  bool isBlocked;
  List<Story> stories;
  List<int> stories_ids =[];
  Category({
    required this.id,
    required this.name,
    required this.isBlocked,
    required this.stories,
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CategoryToJson(this)..['stories_ids'] = stories_ids;

 List<int> getStoriesId(){
  return stories.where((e)=>e.active).map((e) => e.id!).toList();
  }
}
