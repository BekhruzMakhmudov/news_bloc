part of 'category_bloc.dart';

class CategoryState extends Equatable {
  final String selectedCategory;

  const CategoryState({required this.selectedCategory});

  @override
  List<Object> get props => [selectedCategory];
}