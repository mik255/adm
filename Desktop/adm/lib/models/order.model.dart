
import 'package:json_annotation/json_annotation.dart';
import 'category.model.dart';
import 'paymentType.model.dart';
import 'story.model.dart';

part 'order.model.g.dart';

@JsonSerializable()
class Receipt {
  String? id;
  int date;
  String observation;
  List<Story> stories;
  Receipt({
    this.id,
    required this.date,
    required this.stories,
    required this.observation,
  });
  factory Receipt.fromJson(Map<String, dynamic> json) => _$ReceiptFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ReceiptToJson(this);
  double getTotal(){
    double total = 0;
   for (var element in stories) {
    total+=element.getTotal();
  }
   return total;
  }
}

