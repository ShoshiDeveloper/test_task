part of 'categories_bloc.dart';

@immutable
abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}
class CategoriesLoaded extends CategoriesState {
  final List<Category> categories;
  CategoriesLoaded(this.categories);
  }
