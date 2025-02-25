part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class ChangeCategory extends CategoryEvent {
  final String category;

  const ChangeCategory(this.category);

  @override
  List<Object> get props => [category];
}