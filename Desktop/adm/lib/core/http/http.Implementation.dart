
import 'package:dio/dio.dart';

import 'http.ErrorsHandle.dart';
import 'http.Interceptor.dart';
import 'http.dart';
import 'http.Request.dart';
import 'http.Response.dart';

class HttpClientDioImpl implements HttpApiClient {
  late Dio dio;
  late InternetHandleError internetHandleError;

  HttpClientDioImpl({required this.dio}) {
    internetHandleError = InternetHandleError();
    addInterceptor();
  }

  @override
  Future<HttpApiResponse> request(HttpApiRequest request) async {
    Response<dynamic>? response;
    try {
      if (!await internetHandleError.checkInternetConnection()) {
        throw HttpError(
          statusCode: 400,
          message: 'Erro ao conectar com a internet',
        );
      }
      response = await dio.fetch(
        RequestOptions(
          path: request.url,
          data: request.body,
          method: request.method,
        ),
      );
      if(response.statusCode! >= 200 && response.statusCode! <=300 ) {
        return HttpApiResponse(
          statusCode: response.statusCode!,
          data: response.data,
        );
      } else {
        throw HttpError(
          statusCode: response.statusCode??500,
          message: response.data['message']??"25xdff",
        );
      }
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      throw HttpError(
        statusCode: response?.statusCode ?? 500,
        stackTrace: stackTrace,
        message: response?.data['message'] ?? 'Erro inexperado',
      );
    }
  }

  @override
  void addInterceptor() {
    dio.interceptors.add(HttpInterceptor());
  }
}
