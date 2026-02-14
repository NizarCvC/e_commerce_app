part of 'choose_location_cubit.dart';

sealed class ChooseLocationState {}

final class ChooseLocationInitial extends ChooseLocationState {}

final class ChooseLocation extends ChooseLocationState {
  final LocationItemModel chosenLocation;

  ChooseLocation({required this.chosenLocation});
}

final class ConfirmLocationLoading extends ChooseLocationState {}

final class ConfirmLocationSuccess extends ChooseLocationState {}

final class ConfirmLocationError extends ChooseLocationState {
  final String message;

  ConfirmLocationError({required this.message});
}

final class AddingNewLocationLoading extends ChooseLocationState {}

final class AddNewLocationSuccess extends ChooseLocationState {}

final class AddingLocationError extends ChooseLocationState {
  final String message;

  AddingLocationError({required this.message});
}

final class FetchingLocations extends ChooseLocationState {}

final class FetchedLocations extends ChooseLocationState {
  final List<LocationItemModel> fetchedLocations;

  FetchedLocations({required this.fetchedLocations});
}

final class FetchLocationsError extends ChooseLocationState {
  final String message;

  FetchLocationsError({required this.message});
}
