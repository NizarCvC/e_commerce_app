part of 'favorite_cubit.dart';

sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

final class FavoriteLoaded extends FavoriteState {
  final List<ProductItemModel> favoriteProducts;

  FavoriteLoaded({required this.favoriteProducts});
}

final class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError({required this.message});
}

final class RemoveFavoriteLoading extends FavoriteState {
  final String productId;

  RemoveFavoriteLoading({required this.productId});
}

final class RemoveFavoriteSuccess extends FavoriteState {
  final String productId;

  RemoveFavoriteSuccess({required this.productId});
}

final class RemoveFavoriteError extends FavoriteState {
  final String message;

  RemoveFavoriteError({required this.message});
}
