import 'dart:convert';

import 'package:adm/models/story.model.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/constants.dart';
import '../../../core/http/http.ErrorsHandle.dart';
import '../../../core/http/http.Request.dart';
import '../../../core/http/http.Response.dart';
import '../../../mainStances.dart';
import '../../../shared/widgets/customToast.dart';

class StateStorie {}

class StateStorieSucess extends StateStorie {}

class StateStorieLoading extends StateStorie {}

class StateStorieError extends StateStorie {}

class StorieController extends ValueNotifier<StateStorie> {
  StorieController._privateConstructor(super.value);
  static final StorieController instance =
      StorieController._privateConstructor(StateStorieSucess());
  Future<StateStorie> setStory(Story story) async {
    value = StateStorieLoading();
    try {
      value = StateStorieLoading();
      HttpApiResponse httpApiResponse = 
      await MainStances.httpApiClient.request(
          HttpApiRequest(
              url: MainStances.httpRoutes.stories,
              method: 'POST',
              body: story.toJson()
                ..['products_ids'] = Constants.instance.products
                    .where((element) => element.active)
                    .map((e) => e.id)
                    .toList()));
      await Constants.instance.getStories();
      customToast("Loja criado com sucesso");
      value = StateStorieSucess();
      return value;
    } on HttpError catch (e, _) {
      customToast('Erro Loja ');
      customToast(e.message);
      print(e);
      print(_);
    } catch (e, _) {
      print(e);
      print(_);
      customToast(e.toString());
    }
    value = StateStorieSucess();
    return StateStorieError();
  }

  Future<StateStorie> updateStory(Story story) async {
    value = StateStorieLoading();
    try {
      HttpApiResponse httpApiResponse = await MainStances.httpApiClient.request(
          HttpApiRequest(
              url: MainStances.httpRoutes.stories,
              method: 'PUT',
              body: story.toJson()
                ..['products_ids'] = Constants.instance.products
                    .where((element) => element.active)
                    .map((e) => e.id)
                    .toList()));

      if (httpApiResponse.statusCode == 200) {
        await Constants.instance.getStories();
        customToast("Loja editado com sucesso");
        value = StateStorieSucess();
        return value;
      }
    } on HttpError catch (e, _) {
      customToast('Erro loja store');
      customToast(e.message);
      print(e);
      print(_);
    } catch (e, _) {
      print(e);
      print(_);
      customToast(e.toString());
    }
    return StateStorieError();
  }

  Future<StateStorie> deleteStory(Story story) async {
    try {
      value = StateStorieLoading();
      HttpApiResponse httpApiResponse = await MainStances.httpApiClient.request(
          HttpApiRequest(
              url: MainStances.httpRoutes.stories,
              method: 'DELETE',
              body: story.toJson()));
      if (httpApiResponse.statusCode > 200 &&
          httpApiResponse.statusCode < 400) {
        await Constants.instance.getStories();
        customToast("Loja deletado com sucesso");
        value = StateStorieSucess();
        return value;
      }
    } on HttpError catch (e, _) {
      customToast('Erro Loja store');
      customToast(e.message);
      print(e);
      print(_);
    } catch (e, _) {
      print(e);
      print(_);
      customToast(e.toString());
    }
    return StateStorieError();
  }
}
