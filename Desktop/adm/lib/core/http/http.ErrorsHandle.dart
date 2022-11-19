import 'http.Response.dart';

class HttpError implements Exception {
  StackTrace? stackTrace;
  String message;
  int statusCode;
  HttpError({
    this.stackTrace,
    required this.message,
    required this.statusCode,
  });
}

class InternetHandleError {
  Future<bool> checkInternetConnection() async {
    return true;
  }
}
