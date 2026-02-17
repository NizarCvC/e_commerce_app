import 'package:e_commerce_app/models/category_model.dart';
import 'package:e_commerce_app/services/home_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final _homeServices = HomeServicesImpl();

  CategoriesCubit() : super(CategoriesInitial());

  Future<void> fetchCategories() async {
    emit(CategoriesLoading());

    try {
      final categories = await _homeServices.fetchCategories();
      emit(CategoriesLoaded(categories: categories));
    } catch (e) {
      emit(CategoriesError(message: e.toString()));
    }
  }
}
