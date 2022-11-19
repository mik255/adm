import 'package:adm/modules/categories/pages/category_main.dart';
import 'package:adm/modules/categories/store/states.dart';
import 'package:adm/modules/categories/store/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CategoryProvider extends StatelessWidget {
   const CategoryProvider({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ListenableProvider(create: (_)=> CategoriesStore(CategoryLoading())..fetchCategories())
      ],
      child: CategoryMain(),
    );
  }
}

