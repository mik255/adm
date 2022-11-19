import 'package:adm/mainStances.dart';
import 'package:adm/modules/storie/storie_controller/storie_controller.dart';
import 'package:adm/modules/storie/widgets/listProducts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../core/constants.dart';
import '../../models/story.model.dart';
import '../../shared/widgets/circurarLoading.dart';
import '../../shared/widgets/customTextField.dart';
import '../../shared/widgets/dropdown.dart';
import '../../shared/widgets/switchWithTitle.dart';
import '../../shared/widgets/table/TableUiController.dart';
import '../../shared/widgets/table/states.dart';
import '../../shared/widgets/table/widget_table.dart';

class EditStorie extends StatelessWidget {
   EditStorie({Key? key,this.story}) : super(key: key);
   Story? story;
  @override
  Widget build(BuildContext context) {
   story = story??Story(name: '', productList: [], totalPrice: 0, pix: '');
    return  ValueListenableBuilder<StateStorie>(
      valueListenable: StorieController.instance,
      builder: (context, state,child) {
        if(state is StateStorieSucess){
       return Container(
          width: 500,
          child: Column(children: [
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextField(
                            initialText: story?.name,
                            title: 'nome da loja',
                            onChange: (String value) {
                              story!.name = value;
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextField(
                            initialText: story?.pix,
                            title: 'Pix',
                            onChange: (String value) {
                               story!.pix = value;
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
                            initialText: story?.box,
                            title: 'Box',
                            onChange: (String value) {
                               story!.box = value;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SwitchWithTitle(
                          title: "Atividade",
                          initialValue: true,
                          onChange: (v) {
                          
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
                    const Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Adicionar Produtos',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: ListOfProducts(products:Constants.instance.products.map((e) {
                            if (story!.productList.where((element) => element.id == e.id)
                                .isNotEmpty) {
                                 e.active = true;
                            }
                            ;
                            return e;
                          }).toList(),indexOnChangeCallBack: (bool , int ) {  },),
              ),
            ]),
        );
        }
        return CircularLoading();
      }
    
    );
  }
}
