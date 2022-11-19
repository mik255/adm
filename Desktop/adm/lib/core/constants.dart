import 'package:adm/models/category.model.dart';
import 'package:adm/models/product.model.dart';
import 'package:adm/models/story.model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../mainStances.dart';
import '../shared/widgets/customToast.dart';
import 'http/http.ErrorsHandle.dart';
import 'http/http.Request.dart';
import 'http/http.Response.dart';

class Constants {
      Constants._privateConstructor();
  static final Constants instance =
      Constants._privateConstructor();
  Future<void>init()async{
    await Future.wait([
    getStories(),
    fetchCategories(),
    getProducts(),
    ]);

  }
  List<Story> stories = [];
  List<Category> categories = [];
    List<Product> products = [];
  Future<List<Story>> getStories() async {
        try {
      HttpApiResponse httpApiResponse =
          await MainStances.httpApiClient.request(HttpApiRequest(
        url: MainStances.httpRoutes.stories,
        method: 'GET',
      ));
      if (httpApiResponse.statusCode == 200) {
        List<dynamic> data = httpApiResponse.data;
        stories = data.map((e) => Story.fromJson(e)).toList();
        return stories;
      }
    } on HttpError catch (e, _) {
      customToast(e.message);
      print(_);
      return [];
    } catch (e, _) {
      print(_);
      customToast(e.toString());
      return [];
    }
         return [];
  }
   Future<List<Category>?> fetchCategories() async {
    try {
      HttpApiResponse httpApiResponse =
          await MainStances.httpApiClient.request(HttpApiRequest(
        url: MainStances.httpRoutes.categories,
        method: 'GET',
      ));
      if (httpApiResponse.statusCode == 200) {
        List<dynamic> data = httpApiResponse.data;
        return categories = data.map((e) => Category.fromJson(e)).toList();
      }
    } on HttpError catch (e, _) {
      customToast(e.message);
      print(e);
      print(_);
    } catch (e, _) {
      print(e);
      print(_);
      customToast(e.toString());
    }
  }
  Future<List<Product>> getProducts()async{
 try {
      HttpApiResponse httpApiResponse =
          await MainStances.httpApiClient.request(HttpApiRequest(
        url: MainStances.httpRoutes.products,
        method: 'GET',
      ));
      if (httpApiResponse.statusCode == 200) {
        List<dynamic> data = httpApiResponse.data;
        return products = data.map((e) => Product.fromJson(e)).toList();
      }
    } on HttpError catch (e, _) {
      customToast(e.message);
      print(e);
      print(_);
      return [];
    } catch (e, _) {
      print(e);
      print(_);
      customToast(e.toString());
       return [];
    }
     customToast('Erro enexperado!');
     return [];
  }

}
