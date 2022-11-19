// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as int,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      squerePrice: (json['squerePrice'] as num).toDouble(),
      urlImg: json['urlImg'] as String,
      stock: json['stock'] as int?,
      count: json['count'] as int? ?? 0,
      isBlocked: json['isBlocked'] as bool,
      isSelected: json['isSelected'] as bool? ?? false,
    )..active = json['active'] as bool? ?? false;

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'active': instance.active,
      'count': instance.count,
      'stock': instance.stock,
      'squerePrice': instance.squerePrice,
      'urlImg': instance.urlImg,
      'isBlocked': instance.isBlocked,
      'isSelected': instance.isSelected,
    };
