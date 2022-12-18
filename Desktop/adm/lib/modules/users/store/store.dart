

import 'package:flutter/material.dart';

import '../../../core/http/http.ErrorsHandle.dart';
import '../../../core/http/http.Request.dart';
import '../../../core/http/http.Response.dart';
import '../../../mainStances.dart';
import '../../../models/user.model.dart';
import '../../../shared/widgets/customToast.dart';
import '../../products/store/store.dart';

class UserState {}

class UserStateSucess extends UserState {}

class UserStateLoading extends UserState {}

class UsertStateError extends UserState {}

class UserController extends ValueNotifier<UserState> {
  UserController._privateConstructor(super.value);
  static final UserController instance =
      UserController._privateConstructor(UserStateSucess());
   
  Future<UserState> setUser(User user) async {
    value = UserStateLoading();
    try {
      HttpApiResponse httpApiResponse = await MainStances.httpApiClient.request(
          HttpApiRequest(
              url: MainStances.httpRoutes.users,
              method: 'POST',
              body: user.toJson()));

      customToast("user criado com sucesso");
      value = UserStateSucess();
      return value;
    } on HttpError catch (e, _) {
      customToast('Erro user ');
      customToast(e.message);
      print(e);
      print(_);
    } catch (e, _) {
      print(e);
      print(_);
      customToast(e.toString());
    }
    return UsertStateError();
  }

  Future<UserState> updateUser(User user) async {
    value = UserStateLoading();
    try {
      HttpApiResponse httpApiResponse = await MainStances.httpApiClient.request(
          HttpApiRequest(
              url: MainStances.httpRoutes.users,
              method: 'PUT',
              body: user.toJson()));

      if (httpApiResponse.statusCode == 204) {

        customToast("cliente editado com sucesso");
        value = UserStateSucess();
        return value;
      }
    } on HttpError catch (e, _) {
      customToast('Erro Produto store');
      customToast(e.message);
      print(e);
      print(_);
    } catch (e, _) {
      print(e);
      print(_);
      customToast(e.toString());
    }
    return UsertStateError();
  }

  Future<UserState> deleteUser(User user) async {
    try {
      value = UserStateLoading();
      HttpApiResponse httpApiResponse = await MainStances.httpApiClient.request(
          HttpApiRequest(
              url: MainStances.httpRoutes.users,
              method: 'DELETE',
              body: user.toJson()));
      if (httpApiResponse.statusCode > 200 &&
          httpApiResponse.statusCode < 400) {

        customToast("Produto deletado com sucesso");
        value = UserStateSucess();
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
    return UsertStateError();
  }

}
