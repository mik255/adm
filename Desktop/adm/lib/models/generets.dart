import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Order {
  int situacaoPedido;
  int quantidadeTotal;
   num valorTotal;
  String origem;
  Order({
    required this.situacaoPedido,
    required this.quantidadeTotal,
    required this.valorTotal,
    required this.origem,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'situacaoPedido': situacaoPedido,
      'quantidadeTotal': quantidadeTotal,
      'valorTotal': valorTotal,
      'origem': origem,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      situacaoPedido: map['situacaoPedido'] as int,
      quantidadeTotal: map['quantidadeTotal'] as int,
      valorTotal: map['valorTotal'] as num,
      origem: map['origem'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(situacaoPedido: $situacaoPedido, quantidadeTotal: $quantidadeTotal, valorTotal: $valorTotal, origem: $origem)';
  }
}
