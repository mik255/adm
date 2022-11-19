import 'package:json_annotation/json_annotation.dart';

part 'paymentType.model.g.dart';

@JsonSerializable()
class PaymentType {
  String name;

  PaymentType({
    required this.name,
  });
  factory PaymentType.fromJson(Map<String, dynamic> json) => _$PaymentTypeFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PaymentTypeToJson(this);
}

