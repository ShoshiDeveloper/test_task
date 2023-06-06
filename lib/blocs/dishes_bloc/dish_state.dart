part of 'dish_bloc.dart';

@immutable
abstract class DishState {}

class DishInitial extends DishState {}
class DishLoadedState extends DishState {
  final List<Dish> dishes;
  DishLoadedState(this.dishes);
}
