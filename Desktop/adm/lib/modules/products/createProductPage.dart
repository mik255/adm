
import 'package:adm/models/product.model.dart';
import 'package:adm/modules/products/store/store.dart';
import 'package:adm/shared/widgets/circurarLoading.dart';
import 'package:adm/shared/widgets/switchWithTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../shared/widgets/customTextField.dart';

class CreateProductPage extends StatelessWidget {
   CreateProductPage({Key? key,this.product}) : super(key: key);
  Product? product;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ProductState>(
      valueListenable: ProductController.instance,
      builder: (context, state,child) {
        if(state is ProductStateLoading){
          return CircularLoading();
        }
        return Container(
          width: 500,
          child: Column(
            children: [
              ValueListenableBuilder<String>(
                valueListenable: ProductController.instance.imgUrl,
                builder: (context, value,child) {
                  return Column(
                    children: [
                       Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                            height: 150,
                            width: 150,
                            child: Card(
                              child: Image.network(
                                  fit: BoxFit.cover,
                                  value),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextField(
                            initialText: product?.urlImg,
                            title: 'url da imagem',
                            onChange: (String value) {
                              product?.urlImg = value;
                              ProductController.instance.setImgUrlProductFile(value);
                            },
                          ),
                        ),
                       
                    ],
                  );
                }
              ),
              Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomTextField(
                                  initialText: product?.name,
                                  title: 'nome do produto',
                                  onChange: (String value) {
                                      product?.name = value;
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomTextField(
                                  title: 'Descrição',
                                  onChange: (String value) {
                                    
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomTextField(
                                  initialText: product?.price.toString(),
                                  title: 'Preço g20',
                                  onChange: (String value) {
                                           product?.price = double.parse(value);
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomTextField(
                                  initialText: product?.squerePrice.toString(),
                                  title: 'preço praça',
                                  onChange: (String value) {
                                      product?.squerePrice = double.parse(value);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomTextField(
                                  initialText: product?.stock.toString(),
                                  title: 'Estoque',
                                  onChange: (String value) {
                                     product?.stock = int.parse(value);
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SwitchWithTitle(
                                  initialValue: product?.isBlocked??false,
                                  title: 'atividade',
                                  onChange: (v) {
                                     product?.isBlocked = v;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
            ],
          ),
        );
      }
    );
  }
}