import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(const CategoryState(selectedCategory: "general")) {
    on<ChangeCategory>((event, emit) {
      emit(CategoryState(selectedCategory: event.category));
    });
  }
}