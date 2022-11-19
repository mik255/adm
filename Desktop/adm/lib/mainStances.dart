import 'package:adm/core/constants.dart';
import 'package:dio/dio.dart';


import 'core/http/http.Implementation.dart';
import 'core/http/http.dart';
import 'core/http/http.routes.dart';

class MainStances{
  static HttpApiClient httpApiClient = HttpClientDioImpl(dio: Dio());
  static HttpRoutes httpRoutes = HttpRoutes(productionUrl: '', developUrl: 'http://192.168.1.225:8080');
}