import 'package:adm/mainStances.dart';
import 'package:adm/models/category.model.dart';
import 'package:adm/modules/categories/store/store.dart';
import 'package:adm/shared/widgets/selectItems.dart';
import 'package:adm/shared/widgets/showDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants.dart';
import '../../../shared/widgets/customTextField.dart';
import '../../../shared/widgets/dropdown.dart';
import '../../../shared/widgets/searchDropDown.dart';
import '../../../shared/widgets/switchWithTitle.dart';
import '../store/states.dart';
import '../widgets/listOfStories.dart';

class CadasterDialog extends StatelessWidget {
  Function(Category category) onChange;
  CadasterDialog(
      {Key? key,
      this.value,
      required this.onChange,
      required this.categoriesStore})
      : super(key: key);
  Category? value;
  CategoriesStore categoriesStore;
  @override
  Widget build(BuildContext context) {
    Category category =
        value ?? Category(id: 0, name: '', isBlocked: false, stories: []);
    return ValueListenableBuilder(
        valueListenable: categoriesStore,
        builder: (context, state, child) {
          if (state is CategoryLoading) {
            return Container(
              height: 500,
              width: 500,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Center(
            child: Container(
              width: 500,
              child: Scaffold(
                body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (false)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 100,
                            width: 100,
                            color: Colors.grey,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextField(
                          initialText: category.name,
                          onChange: (String value) {
                            category.name = value;
                            onChange.call(category);
                          },
                          title: 'Nome da categoria',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SwitchWithTitle(
                          title: "Atividade",
                          initialValue: category.isBlocked,
                          onChange: (v) {
                            category.isBlocked = v;
                            onChange.call(category);
                          },
                        ),
                      ),
                      const Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Lojas',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListOfStories(
                          stories: Constants.instance.stories.map((e) {
                            if (category.stories.where((element) => element.id == e.id)
                                .isNotEmpty) {
                                 e.active = true;
                            }
                            ;
                            return e;
                          }).toList(),
                          indexOnChangeCallBack: (v, i) {},
                        ),
                      ),
                    ]),
              ),
            ),
          );
        });
  }
}
