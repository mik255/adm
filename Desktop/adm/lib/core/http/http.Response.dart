
class HttpApiResponse{
  int statusCode;
  dynamic data;
  HttpApiResponse({
    required this.statusCode,
    this.data,
  });
}
