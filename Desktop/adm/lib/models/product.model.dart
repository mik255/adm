import 'package:json_annotation/json_annotation.dart';

part 'product.model.g.dart';

@JsonSerializable()
class Product {
  int? id;
  String name;
  double price;
  
  @JsonKey(defaultValue: false, disallowNullValue: false)
  bool active = false;
  @JsonKey(defaultValue: 0, disallowNullValue: false)
  int count;
  int? stock;
  double squerePrice;
  String urlImg;
  bool isBlocked;
  bool isSelected;
  Product({
    this.id,
    required this.name,
    required this.price,
    required this.squerePrice,
    required this.urlImg,
    this.stock,
    this.count = 0,
    required this.isBlocked,
    this.isSelected = false
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  clear() {
    count = 0;
  }
  double getTotal(){
    return count*price;
  }
}
