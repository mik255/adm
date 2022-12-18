import 'package:dio/dio.dart';

class HttpInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) {
    print('--> ${options.method} ${options.path}');
    print('body --> ${options.data}');
    handler.next(options);
  }

  @override
  void onResponse(
      Response response,
      ResponseInterceptorHandler handler,
      ) {
    //print('<-- ${response.statusCode} ${response.data}');
    handler.next(response);
  }

  @override
  void onError(
      DioError err,
      ErrorInterceptorHandler handler,
      ) {
    print('<-- ${err.response?.statusCode} ${err.response?.data}');
    handler.next(err);
  }
}