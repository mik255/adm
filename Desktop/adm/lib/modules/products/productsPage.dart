import 'package:adm/modules/products/store/store.dart';
import 'package:adm/shared/widgets/circurarLoading.dart';
import 'package:adm/shared/widgets/customTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../shared/widgets/dataTableGrid.dart';
import '../../../../shared/widgets/dropdown.dart';
import '../../../../shared/widgets/table/TableUiController.dart';
import '../../../../shared/widgets/table/states.dart';
import '../../../../shared/widgets/table/widget_table.dart';
import '../../core/constants.dart';
import '../../models/product.model.dart';
import '../../shared/widgets/showDialog.dart';
import 'createProductPage.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
   
    return Scaffold(
      body: ValueListenableBuilder<ProductState>(
        valueListenable: ProductController.instance,
        builder: (context, state,child) {
          TableUiController tableUiControllerRequiriments =
      TableUiController(TableUiState(headers: [
      TableHeader(value: const Text("Nome")),
      TableHeader(value: const Text("Estoque")),
      TableHeader(value: const Text("Preço g20")),
      TableHeader(value: const Text("Preço praça")),
      TableHeader(
          value: Row(
        children: const [
          Spacer(),
          Padding(
            padding: EdgeInsets.only(right: 48.0),
            child: Text("Ações"),
          ),
        ],
      )),
    ], tableDataList: [
      ...Constants.instance.products.map((e) =>
      [
        TableCellRow(value: Text(e.name)),
        TableCellRow(value: Text(e.stock.toString())),
        TableCellRow(value: Text(e.price.toString())),
        TableCellRow(value: Text(e.squerePrice.toString())),
        TableActions(actions: [
          InkWell(
            mouseCursor: SystemMouseCursors.click,
            onTap: () {},
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
            onTap: () {},
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
          if(state is ProductStateSucess){
            Product product = Product(
                          name: '',price: 0,squerePrice: 0,urlImg: '',isBlocked: false
                         );
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                      TableUi(
                      isSelected: false,
                      extraLines: 0,
                      tableUiController: tableUiControllerRequiriments,
                      addCallBack: () {
                         DialogUtil().showDialogUtil(title:'Formulario Produto',context, CreateProductPage(product: product,),
                      onSave: (()async{ await ProductController.instance.setProduct(product); return true;}));
                      })
                ],
              ),
            ),
          );
        }
        return CircularLoading();
        }
      ),
    );
  }
}
