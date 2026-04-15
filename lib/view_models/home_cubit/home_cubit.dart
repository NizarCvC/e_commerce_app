import 'package:e_commerce_app/models/home_carousel_item_model.dart';
import 'package:e_commerce_app/models/product_item_model.dart';
import 'package:e_commerce_app/services/auth_services.dart';
import 'package:e_commerce_app/services/favorite_services.dart';
import 'package:e_commerce_app/services/home_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final _homeServices = HomeServicesImpl();
  final _favoriteServices = FavoriteServicesImpl();
  final _authServices = AuthServicesImpl();

  HomeCubit() : super(HomeInitial());

  Future<void> getHomeData() async {
    emit(HomeLoading());
    try {
      List<ProductItemModel> fetchedProducts = await _homeServices
          .fetchProducts();
      final homeCarouselItems = await _homeServices.fetchCarouselItems();
      final favoriteProducts = await _favoriteServices.fetchFavoritesProducts(
        _authServices.currentUser()!.uid,
      );
      fetchedProducts = fetchedProducts.map((product) {
        final isFavorite = favoriteProducts.any((e) => e.id == product.id);
        return product.copyWith(isFavorite: isFavorite);
      }).toList();
      emit(
        HomeLoaded(products: fetchedProducts, carouselItems: homeCarouselItems),
      );
    } catch (e) {
      HomeError(message: e.toString());
    }
  }

  Future<void> setFavorite(ProductItemModel product) async {
    emit(SetFavoriteLoading(productId: product.id));
    try {
      final currentUser = _authServices.currentUser();
      final favoriteProducts = await _favoriteServices.fetchFavoritesProducts(
        currentUser!.uid,
      );
      final isFavorite = favoriteProducts.any((e) => e.id == product.id);
      if (isFavorite) {
        await _favoriteServices.removeFavoriteProduct(currentUser.uid, product.id);
      } else {
        await _favoriteServices.addFavoriteProduct(currentUser.uid, product);
      }
      emit(SetFavoriteSuccess(productId: product.id, isFavorite: !isFavorite));
    } catch (e) {
      emit(SetFavoriteError(productId: product.id, message: e.toString()));
    }
  }
}
