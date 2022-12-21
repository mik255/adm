import 'package:flutter/cupertino.dart';

import '../../../core/constants.dart';
import '../../../core/http/http.ErrorsHandle.dart';
import '../../../core/http/http.Request.dart';
import '../../../core/http/http.Response.dart';
import '../../../mainStances.dart';
import '../../../models/product.model.dart';
import '../../../shared/widgets/customToast.dart';
import '../../storie/storie_controller/storie_controller.dart';

class ProductState {}

class ProductStateSucess extends ProductState {}

class ProductStateLoading extends ProductState {}

class ProductStateError extends ProductState {}

class ProductController extends ValueNotifier<ProductState> {
  ProductController._privateConstructor(super.value);
  static final ProductController instance =
      ProductController._privateConstructor(ProductStateSucess());
   
   ValueNotifier<String> imgUrl =  ValueNotifier<String>('');
  Future<ProductState> setProduct(Product product) async {
    value = ProductStateLoading();
    try {
      HttpApiResponse httpApiResponse = await MainStances.httpApiClient.request(
          HttpApiRequest(
              url: MainStances.httpRoutes.products,
              method: 'POST',
              body: product.toJson()));

      await Constants.instance.getProducts();
      customToast("Produto criado com sucesso");
      value = ProductStateSucess();
      return value;
    } on HttpError catch (e, _) {
      customToast('Erro Produto ');
      customToast(e.message);
      print(e);
      print(_);
    } catch (e, _) {
      print(e);
      print(_);
      customToast(e.toString());
    }
    return ProductStateError();
  }

Future<ProductState> updateProduct(Product product) async {
    value = ProductStateLoading();
    try {
      HttpApiResponse httpApiResponse = await MainStances.httpApiClient.request(
          HttpApiRequest(
              url: MainStances.httpRoutes.products,
              method: 'PUT',
              body: product.toJson()));

      if (httpApiResponse.statusCode == 204) {
        await Constants.instance.getProducts();
        customToast("Produto editado com sucesso");
        value = ProductStateSucess();
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
    return ProductStateError();
  }

  Future<ProductState> deleteProduct(Product product) async {
    try {
      value = ProductStateLoading();
      HttpApiResponse httpApiResponse = await MainStances.httpApiClient.request(
          HttpApiRequest(
              url: MainStances.httpRoutes.products,
              method: 'DELETE',
              body: product.toJson()));
      if (httpApiResponse.statusCode > 200 &&
          httpApiResponse.statusCode < 400) {
        await Constants.instance.getProducts();
        customToast("Produto deletado com sucesso");
        value = ProductStateSucess();
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
    return value;
  }

  void setImgUrlProductFile(String url){
   imgUrl.value = url;
  }
}
