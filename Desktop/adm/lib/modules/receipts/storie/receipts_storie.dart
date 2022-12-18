

import 'package:adm/core/constants.dart';
import 'package:adm/models/receipt.dart';
import 'package:adm/shared/widgets/customToast.dart';
import 'package:flutter/material.dart';

import '../../../core/http/http.ErrorsHandle.dart';
import '../../../core/http/http.Request.dart';
import '../../../core/http/http.Response.dart';
import '../../../mainStances.dart';

class ReceiptState {}

class ReceiptStateSucess extends ReceiptState {
  ReceiptStateSucess({this.allReceipts,this.currentUserReceipts});
  List<Receipt>? currentUserReceipts = [];
  List<Receipt>? allReceipts = [];
}

class ReceiptStateLoading extends ReceiptState {}

class ReceiptStateError extends ReceiptState {
  ReceiptStateError({required this.msg});
  String msg;
}

class ReceiptController extends ValueNotifier<ReceiptState> {
  ReceiptController._privateConstructor(super.value);
   List<Receipt> usersReceipt = [];
  static final ReceiptController instance =
      ReceiptController._privateConstructor(ReceiptStateSucess());
   
   ValueNotifier<String> imgUrl =  ValueNotifier<String>('');
 
  Future<ReceiptState> deleteProduct(Receipt receipt) async {
    try {
      value = ReceiptStateLoading();
      HttpApiResponse httpApiResponse = await MainStances.httpApiClient.request(
          HttpApiRequest(
              url: MainStances.httpRoutes.stories,
              method: 'DELETE',
              body: receipt.toJson()));
      if (httpApiResponse.statusCode > 200 &&
          httpApiResponse.statusCode < 400) {
        await Constants.instance.getReceipts();
        customToast("sucesso");
        value = ReceiptStateSucess();
        return value;
      }
    } on HttpError catch (e, _) {
      customToast('Erro Loja store');
      customToast(e.message);
      print(e);
      print(_);
       return ReceiptStateError(msg: e.toString());
    } catch (e, _) {
      print(e);
      print(_);
      customToast(e.toString());
      return ReceiptStateError(msg: e.toString());
    }
     return ReceiptStateError(msg: 'inexpected error');
  }
  Future<ReceiptState> getByUserId(int id) async {
    try {
      value = ReceiptStateLoading();
      HttpApiResponse httpApiResponse = await MainStances.httpApiClient.request(
          HttpApiRequest(
              url: MainStances.httpRoutes.receiptUserById,
              method: 'POST',
              body: '{"id":$id}'));
      if (httpApiResponse.statusCode == 200 ) {
         List<dynamic> data = httpApiResponse.data;
         usersReceipt = data.map((e) => Receipt.fromMap(e)).toList();
        customToast("sucesso");
        value = ReceiptStateSucess(
         currentUserReceipts: usersReceipt
        );
        return value;
      }
    } on HttpError catch (e, _) {
      customToast('Erro Loja store');
      customToast(e.message);
      print(e);
      print(_);
       return ReceiptStateError(msg: e.toString());
    } catch (e, _) {
      print(e);
      print(_);
      customToast(e.toString());
       return ReceiptStateError(msg: e.toString());
    }
    return ReceiptStateError(msg: 'inexpected error');
  }

}
