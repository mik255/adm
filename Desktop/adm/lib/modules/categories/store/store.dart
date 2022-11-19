

import 'package:adm/core/http/http.Request.dart';
import 'package:adm/core/http/http.Response.dart';
import 'package:adm/mainStances.dart';
import 'package:adm/models/story.model.dart';
import 'package:adm/modules/categories/store/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/constants.dart';
import '../../../core/http/http.ErrorsHandle.dart';
import '../../../models/category.model.dart';
import '../../../shared/widgets/GenericError.dart';
import '../../../shared/widgets/customToast.dart';

class CategoriesStore extends ValueNotifier<CategoriesStates>{
  CategoriesStore(super.value);

  void fetchCategories() async {
    value = CategoryLoading();
    try {
        value = CategoryState(
            categories: Constants.instance.categories
        );
    } on HttpError catch (e, _) {
      value = CategoryError();
      Fluttertoast.showToast(
          msg: e.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
      print(_);
    }
    catch (e, _) {
      value = CategoryError();
      print(_);
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
bool validateIfCanContinue(String name){
 if(name == ''){
   customToast("Nome não pode ser vazio");
  return false;
 }
 return true;
}
  Future<CategoriesStates> setCategory(Category category)async{
    if(!validateIfCanContinue(category.name)){
      return CategoryError();
    }
      value = CategoryLoading();
    try {
      print(category.toJson());
      category.stories_ids = Constants.instance.stories.where((element) 
        => element.active).map((e) => e.id!).toList();
      HttpApiResponse httpApiResponse =
          await MainStances.httpApiClient.request(HttpApiRequest(
        url: MainStances.httpRoutes.categories,
        method: 'POST',
        body: category.toJson()
        ..['stories_ids'] = Constants.instance.stories.where((element) 
        => element.active).map((e) => e.id).toList()
      ));
      if (httpApiResponse.statusCode == 200) {
        List<Category>? categories = await Constants.instance.fetchCategories();
          customToast("Categoria criado com sucesso");
        value = CategoryState(categories: categories!);
        return value;
      }
    } on HttpError catch (e, _) {
        customToast('Erro category store');
      customToast(e.message);
      print(e);
      print(_);
    } catch (e, _) {
      print(e);
      print(_);
      customToast(e.toString());
  }
return CategoryError();
  }

Future<CategoriesStates> editCategory(Category category)async{
    if(!validateIfCanContinue(category.name)){
      return CategoryError();
    }
      value = CategoryLoading();
    try {
      HttpApiResponse httpApiResponse =
          await MainStances.httpApiClient.request(HttpApiRequest(
        url: MainStances.httpRoutes.categories,
        method: 'PUT',
        body: category.toJson()
      ));
      if (httpApiResponse.statusCode == 200) {
        List<Category>? categories = await Constants.instance.fetchCategories();
          customToast("Categoria editado com sucesso");
        value = CategoryState(categories: categories!);
        return value;
      }
    } on HttpError catch (e, _) {
        customToast('Erro category store');
      customToast(e.message);
      print(e);
      print(_);
    } catch (e, _) {
      print(e);
      print(_);
      customToast(e.toString());
  }
return CategoryError();
  }

Future<CategoriesStates> deleteCategory(Category category)async{

    
    try {
        value = CategoryLoading();
      HttpApiResponse httpApiResponse =
          await MainStances.httpApiClient.request(HttpApiRequest(
        url: MainStances.httpRoutes.categories,
        method: 'DELETE',
        body: category.toJson()
      ));
      if (httpApiResponse.statusCode == 200) {
        List<Category>? categories = await Constants.instance.fetchCategories();
          customToast("Categoria deletado com sucesso");
        value = CategoryState(categories: categories!);
        return value;
      }
    } on HttpError catch (e, _) {
        customToast('Erro category store');
      customToast(e.message);
      print(e);
      print(_);
    } catch (e, _) {
      print(e);
      print(_);
      customToast(e.toString());
  }
return CategoryError();
  }

Future<CategoriesStates> setStories(List<Story> stories)async{

      value = CategoryLoading();
    try {
      HttpApiResponse httpApiResponse =
          await MainStances.httpApiClient.request(HttpApiRequest(
        url: MainStances.httpRoutes.categories+'/stories',
        method: 'POST',
        body: stories.map((e) => e.toJson()).toList()
      ));
      if (httpApiResponse.statusCode == 200) {
        List<Category>? categories = await Constants.instance.fetchCategories();
          customToast("Lojas adicionadas com sucesso");
        value = CategoryState(categories: categories!);
        return value;
      }
    } on HttpError catch (e, _) {
        customToast('Erro category store');
      customToast(e.message);
      print(e);
      print(_);
    } catch (e, _) {
      print(e);
      print(_);
      customToast(e.toString());
  }
return CategoryError();
  }

}