import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import '../../API/api.dart';
import '../../API/category.dart';
import 'package:test_task/API/category.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial()) {
    on<GetCategoriesEvent>(_getCategories);
  }

  _getCategories(GetCategoriesEvent event, Emitter<CategoriesState> emit) async {
    List<Category> categories = List.empty();
    final dio = Dio();
    final client = RestClient(dio);
    categories = await client.getCategories();
    // print(categories[0].)
    emit(CategoriesLoaded(categories));
  }
}
