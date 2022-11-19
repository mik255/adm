
class HttpApiRequest {
  String url;
  String method;
  dynamic body;
  HttpApiRequest({
    required this.url,
    this.body,
    required this.method,

  });
}