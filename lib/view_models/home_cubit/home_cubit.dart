import 'package:e_commerce_app/models/home_carousel_item_model.dart';
import 'package:e_commerce_app/models/product_item_model.dart';
import 'package:e_commerce_app/services/home_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final _homeServices = HomeServicesImpl();

  HomeCubit() : super(HomeInitial());

  Future<void> getHomeData() async {
    emit(HomeLoading());
    try {
      final fetchedProducts = await _homeServices.fetchProducts();
      final homeCarouselItems = await _homeServices.fetchCarouselItems();
      products = fetchedProducts;
      emit(
        HomeLoaded(products: fetchedProducts, carouselItems: homeCarouselItems),
      );
    } catch (e) {
      HomeError(message: e.toString());
    }
  }
}
