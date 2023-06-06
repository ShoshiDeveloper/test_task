import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../API/dishes/dish.dart';
import '../../StaticData.dart';

part 'bucket_event.dart';
part 'bucket_state.dart';

class BucketBloc extends Bloc<BucketEvent, BucketState> {
  int priceSummary = 0;
  //данные о корзине можно и здесь хранить, а не в статике
  BucketBloc() : super(BucketInitial()) {
    on<GetBucketDishesEvent>(_getBucketDishes);
    on<MinusBucketDishEvent>(_minusDish);
    on<PlusBucketDishEvent>(_plusDish);
  }

  _getBucketDishes(GetBucketDishesEvent event, Emitter<BucketState> emit) {
    StaticData.dishes.forEach((element) => priceSummary+=element.price!*element.count);
    emit(BucketLoadedState(StaticData.dishes));
  }
  _minusDish(MinusBucketDishEvent event, Emitter<BucketState> emit) {
    if (StaticData.dishes[event.id].count == 1) {
      StaticData.dishes.removeAt(event.id);
    }
    else {
      StaticData.dishes[event.id].count--;
    priceSummary -= StaticData.dishes[event.id].price!;
    }
    
    
    emit(BucketLoadedState(StaticData.dishes));
  }
  _plusDish(PlusBucketDishEvent event, Emitter<BucketState> emit) {
    StaticData.dishes[event.id].count += 1;
    priceSummary += StaticData.dishes[event.id].price!;
    print("PLUS");
    emit(BucketLoadedState(StaticData.dishes));
  }
}
