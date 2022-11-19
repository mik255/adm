
import 'http.Request.dart';
import 'http.Response.dart';
abstract class HttpApiClient {
  void addInterceptor();
  Future<HttpApiResponse> request(HttpApiRequest request);
}


