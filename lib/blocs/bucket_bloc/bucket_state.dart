part of 'bucket_bloc.dart';

@immutable
abstract class BucketState {}

class BucketInitial extends BucketState {}
class BucketLoadedState extends BucketState {
  final List<Dish> dishes;
  BucketLoadedState(this.dishes);
}
