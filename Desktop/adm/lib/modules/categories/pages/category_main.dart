import 'dart:js';

import 'package:adm/models/category.model.dart';
import 'package:adm/modules/categories/store/states.dart';
import 'package:adm/modules/categories/store/store.dart';
import 'package:adm/shared/widgets/GenericError.dart';
import 'package:adm/modules/categories/pages/cadasterDialog.dart';
import 'package:adm/shared/widgets/customTextField.dart';
import 'package:adm/shared/widgets/customToast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import '../../../../shared/widgets/dataTableGrid.dart';
import '../../../../shared/widgets/dropdown.dart';
import '../../../../shared/widgets/table/TableUiController.dart';
import '../../../../shared/widgets/table/states.dart';
import '../../../../shared/widgets/table/widget_table.dart';
import '../../../core/constants.dart';
import '../../../mainStances.dart';
import '../../../shared/widgets/showDialog.dart';

class CategoryMain extends StatelessWidget {
  CategoryMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CategoriesStore categoriesStore = context.read<CategoriesStore>();
    Category? category;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
                          DialogUtil().showDialogUtil(title:'Formulario Categoria',context, CadasterDialog(
                            categoriesStore: categoriesStore,
                            onChange: (value) {
                              category = value;
                                 
                            },
                          ), onSave: () async {
                            if (category == null) {
                              return false;
                            }
                            CategoriesStates result =
                                await categoriesStore.setCategory(category!);
                            if (result is CategoryState) {
                              return true;
                            }
                            return false;
                          });
                        },
      ),
      body: ValueListenableBuilder<CategoriesStates>(
          valueListenable: categoriesStore,
          builder: (context, state, child) {
            if (state is CategoryState) {
              TableUiController tableUiControllerRequiriments =
                  TableUiController(TableUiState(headers: [
                TableHeader(value: const Text("Categoria")),
                TableHeader(value: Center(child: Text("Atividade",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),))),
                TableHeader(
                    value: Row(
                  children: const [
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 48.0),
                      child: Text("Ações",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                    ),
                  ],
                )),
              ], tableDataList: [
                ...state.categories.map((e) => [
                      TableCellRow(value: Text(e.name)),
                      TableCellRow(value: Checkbox(value: e.isBlocked,onChanged: (v){},)),
                      TableActions(actions: [
                        InkWell(
                          mouseCursor: SystemMouseCursors.click,
                          onTap: () {
                          DialogUtil().showDialogUtil(title:'Formulario Categoria',context, CadasterDialog(
                            value:e,
                            categoriesStore: categoriesStore,
                            onChange: (value) {
                              category = value;
                            },
                          ), onSave: () async {
                            if (category == null) {
                              customToast('categoria nula');
                              return false;
                            }
                            category!.stories_ids = Constants.instance.stories.where((e) => e.active).map((e) =>e.id!).toList();
                            CategoriesStates result =
                                await categoriesStore.editCategory(category!);
                            if (result is CategoryState) {
                              return true;
                            }
                            return false;
                          });
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
                              child: ValueListenableBuilder<CategoriesStates>(
                                valueListenable: categoriesStore,
                                builder: (context,store,child) {
                                
                                  if(state is CategoryLoading){
                                   
                                    return Center(child: CircularProgressIndicator(),);
                                  }
                                  return AlertDialog(title: Text('Deletar categoria, tem certeza ?'),);
                                }
                              ),
                            ), onSave: () async {
                                Navigator.of(context).pop();
                            CategoriesStates result =
                                await categoriesStore.deleteCategory(e);
                            if (result is CategoryState) {
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
                         ]),
                    ])
              ]));

              return Container(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    
                    children: [
                      TableUi(
                        title: 'Categorias',
                          isSelected: false,
                          extraLines: 0,
                          tableUiController: tableUiControllerRequiriments,
                          addCallBack: () {
                            DialogUtil().showDialogUtil(
                              title:'Formulario Categoria',
                              context, CadasterDialog(
                              categoriesStore: categoriesStore,
                              onChange: (value) {
                                category = value;
                                   
                              },
                            ), onSave: () async {
                              if (category == null) {
                                return false;
                              }
                              category!.stories_ids = Constants.instance.stories.where((e) => e.active).map((e) =>e.id!).toList();
                              CategoriesStates result =
                                  await categoriesStore.setCategory(category!);
                              if (result is CategoryState) {
                                return true;
                              }
                              return false;
                            });
                          })
                    ],
                  ),
                ),
              );
            }
            if (state is CategoryError) {
              return GenericError(
                  title: 'Erro',
                  subtitle: "Erro no servidor ao trazer as categorias",
                  errorCode: 'CategoryError');
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
