import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

import '../../API/dishes/dish.dart';
import '../../API/dishes/dishapi.dart';

part 'dish_event.dart';
part 'dish_state.dart';

class DishBloc extends Bloc<DishEvent, DishState> {
  DishBloc() : super(DishInitial()) {
    on<GetDishesEvent>(_getDishes);
  }

  _getDishes(GetDishesEvent event, Emitter<DishState> emit) async {
    List<Dish> dishes = List.empty();
    final dio = Dio();
    final client = RestClient(dio);
    dishes = await client.getDishes();
    // print(dishes.where((Dish element) => element.tegs!.contains('Все меню')));
    emit(DishLoadedState(dishes));
  }
}
