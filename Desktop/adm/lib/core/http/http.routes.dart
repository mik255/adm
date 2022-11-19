class HttpRoutes{
  HttpRoutes({
    required this.productionUrl,
    required this.developUrl,
  }){
    if(const String.fromEnvironment('Production') == 'true') {
      baseUrl = productionUrl;
    } else {
      baseUrl = developUrl;
    }
  }
  String productionUrl;
  String developUrl;
  late String baseUrl;
  String get login => 'http://35.237.134.14:8080/login';
  String get register => '$baseUrl/register';
  String get categories => '$baseUrl/category';
  String get historyReceipts => '$baseUrl/historyReceipt';
  String get orders => '$baseUrl/orders';
  String get results => '$baseUrl/resultados';
  String get receipt => '$baseUrl/receipt';
  String get stories => '$baseUrl/stories';
  String get products => '$baseUrl/products';
}