

import 'package:adm/models/category.model.dart';

class CategoriesStates{}
class CategoryState extends CategoriesStates{
  CategoryState({required this.categories});
  List<Category> categories;
}
class CategoryLoading extends CategoriesStates{}
class CategoryError extends CategoriesStates{}
