import 'package:e_commerce_app/models/product_item_model.dart';
import 'package:e_commerce_app/services/auth_services.dart';
import 'package:e_commerce_app/services/favorite_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final _authServices = AuthServicesImpl();
  final _favoriteServices = FavoriteServicesImpl();

  FavoriteCubit() : super(FavoriteInitial());

  Future<void> getFavoriteProducts() async {
    emit(FavoriteLoading());
    try {
      final currentUser = _authServices.currentUser();
      final favoriteProducts = await _favoriteServices.fetchFavoritesProducts(
        currentUser!.uid,
      );
      emit(FavoriteLoaded(favoriteProducts: favoriteProducts));
    } catch (e) {
      emit(FavoriteError(message: e.toString()));
    }
  }

  Future<void> removeFavorite(ProductItemModel product) async {
    emit(RemoveFavoriteLoading(productId: product.id));
    try {
      final currentUser = _authServices.currentUser();
      await _favoriteServices.removeFavoriteProduct(
        currentUser!.uid,
        product.id,
      );
      final favoriteProducts = await _favoriteServices.fetchFavoritesProducts(
        currentUser.uid,
      );
      emit(FavoriteLoaded(favoriteProducts: favoriteProducts));
      emit(RemoveFavoriteSuccess(productId: product.id));
    } catch (e) {
      emit(RemoveFavoriteError(message: e.toString()));
    }
  }
}
