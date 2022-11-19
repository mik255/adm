// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as int,
      name: json['name'] as String,
      isBlocked: json['isBlocked'] as bool,
      stories: (json['stories'] as List<dynamic>)
          .map((e) => Story.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..stories_ids =
        (json['stories_ids'] as List<dynamic>).map((e) => e as int).toList();

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isBlocked': instance.isBlocked,
      'stories': instance.stories,
      'stories_ids': instance.stories_ids,
    };
