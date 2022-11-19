class Results {
  double? g20total;
  int? totalOrders;
  double? marginProfit;
  double? ticket;
  double? priceSquare;
  double? g20Price;

  Results(
      {this.g20total,
        this.totalOrders,
        this.marginProfit,
        this.ticket,
        this.priceSquare,
        this.g20Price});

  Results.fromJson(Map<String, dynamic> json) {
    g20total = json['g20total'];
    totalOrders = json['totalOrders'];
    marginProfit = json['marginProfit'];
    ticket = json['ticket'];
    priceSquare = json['priceSquare'];
    g20Price = json['g20Price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['g20total'] = this.g20total;
    data['totalOrders'] = this.totalOrders;
    data['marginProfit'] = this.marginProfit;
    data['ticket'] = this.ticket;
    data['priceSquare'] = this.priceSquare;
    data['g20Price'] = this.g20Price;
    return data;
  }
}
