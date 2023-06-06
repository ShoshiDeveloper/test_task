part of 'bucket_bloc.dart';

@immutable
abstract class BucketEvent {}
class GetBucketDishesEvent extends BucketEvent {
  
}
class MinusBucketDishEvent extends BucketEvent {
  final int id;
  MinusBucketDishEvent(this.id);
}
class PlusBucketDishEvent extends BucketEvent {
  final int id;
  PlusBucketDishEvent(this.id);
}