part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<ProductItemModel> products;
  final List<HomeCarouselItemModel> carouselItems;

  HomeLoaded({required this.products, required this.carouselItems});
}

final class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}

final class SetFavoriteLoading extends HomeState {
  final String productId;

  SetFavoriteLoading({required this.productId});
}

final class SetFavoriteSuccess extends HomeState {
  final String productId;
  final bool isFavorite;

  SetFavoriteSuccess({required this.productId, required this.isFavorite, });
}

final class SetFavoriteError extends HomeState {
  final String productId;
  final String message;

  SetFavoriteError({required this.message, required this.productId});
}
