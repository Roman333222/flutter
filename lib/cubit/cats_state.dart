import '../models/cat_image.dart';

abstract class CatsState {}

class CatsLoading extends CatsState {}

class CatsLoaded extends CatsState {
  CatsLoaded(this.cats);
  final List<CatImage> cats;
}

class CatsError extends CatsState {}
