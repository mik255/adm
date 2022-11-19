import 'package:adm/modules/storie/edit_storie.dart';
import 'package:adm/modules/storie/storie_controller/storie_controller.dart';
import 'package:adm/shared/widgets/circurarLoading.dart';
import 'package:adm/shared/widgets/customTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../shared/widgets/dataTableGrid.dart';
import '../../../shared/widgets/dropdown.dart';
import '../../../shared/widgets/table/TableUiController.dart';
import '../../../shared/widgets/table/states.dart';
import '../../../shared/widgets/table/widget_table.dart';
import '../../core/constants.dart';
import '../../mainStances.dart';
import '../../models/story.model.dart';
import '../../shared/widgets/showDialog.dart';

class StorieRegister extends StatelessWidget {
  const StorieRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    
 return ValueListenableBuilder<StateStorie>(
   valueListenable: StorieController.instance,
   builder: (context, state,child) {
    TableUiController tableUiControllerRequiriments =
        TableUiController(TableUiState(headers: [
      TableHeader(value: const Text("Nome",)),
      TableHeader(value: const Text("pix")),
      TableHeader(value: const Text("total")),
      TableHeader(value: const Text("N° Produtos")),
      TableHeader(
          value: Row(
        children: const [
          Spacer(),
          Padding(
            padding: EdgeInsets.only(right: 48.0),
            child: Text("Ações",style: TextStyle(color: Colors.white)),
          ),
        ],
      )),
    ], tableDataList: [
      ...Constants.instance.stories.map((e) => [
        TableCellRow(value: Text(e.name)),
        TableCellRow(value: Text(e.pix)),
        TableCellRow(value: Text('R\$ ${e.totalPrice}')),
        TableCellRow(value: Text(e.productList.length.toString())),
        TableActions(actions: [
          InkWell(
            mouseCursor: SystemMouseCursors.click,
            onTap: () {
                   DialogUtil().showDialogUtil(title:'Formulario Loja',context, EditStorie(story: e,),
                   onSave: (() => StorieController.instance.updateStory(e)));
                },
            child: const Padding(
              padding: EdgeInsets.all(2),
              child: Icon(
                Icons.edit,
                color: Colors.blue,
              ),
            ),
          ),
          InkWell(
            mouseCursor: SystemMouseCursors.click,
            onTap: () {
               DialogUtil().showDialogUtil(
                            title: 'Formulario Categoria',
                            buttomName:'delete',
                            context, Container(
                              height: 300,width: 300,
                              child: ValueListenableBuilder<StateStorie>(
                                valueListenable: StorieController.instance,
                                builder: (context,state,child) {
                                
                                  if(state is StateStorieLoading){
                                   
                                    return CircularLoading();
                                  }
                                  return AlertDialog(title: Text('Deletar Loja, tem certeza ?'),);
                                }
                              ),
                            ), onSave: () async {
                                Navigator.of(context).pop();
                            StateStorie result =
                                await StorieController.instance.deleteStory(e);
                            if (result is StateStorieSucess) {
                              return true;
                            }
                            return false;
                          });
                        
            },
            child: const Padding(
              padding: EdgeInsets.all(2),
              child: Icon(
                Icons.delete,
                color: Colors.blue,
              ),
            ),
          ),
          InkWell(
            mouseCursor: SystemMouseCursors.click,
            onTap: () {
              Future<void> _selectDate(BuildContext context) async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDatePickerMode: DatePickerMode.day,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1998),
                  lastDate: DateTime.now(),
                );
              }

              _selectDate(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(2),
              child: Icon(
                Icons.calendar_month,
                color: Colors.red,
              ),
            ),
          )
        ]),
      ]
    )]));
 
 Story story = Story(name: '', productList: [], totalPrice: 0, pix: '');
    if(state is StateStorieLoading){
      return CircularLoading();
    }
     return Scaffold(
       body: SingleChildScrollView(
         child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               TableUi(
               isSelected: false,
               extraLines: 0,
               tableUiController: tableUiControllerRequiriments,
               addCallBack: () {
                  DialogUtil().showDialogUtil(title:'Formulario Loja',context, EditStorie(story: story,),
                  onSave: (()async{ await StorieController.instance.setStory(story); return true;}));
               })
              ],
            ),
       ),
     );
   }
 );
  }
}
