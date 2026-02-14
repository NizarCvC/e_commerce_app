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
