import 'package:e_commerce_app/models/location_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'choose_location_state.dart';

class ChooseLocationCubit extends Cubit<ChooseLocationState> {
  ChooseLocationCubit() : super(ChooseLocationInitial());

  String locationId = locations.first.id;

  void fetchLocations() {
    emit(FetchingLocations());

    Future.delayed(Duration(seconds: 1), () {
      if (locations.isNotEmpty) {
        final chosenLocation = locations.singleWhere(
          (e) => e.isChosen == true,
          orElse: () => locations.first,
        );
        emit(FetchedLocations(fetchedLocations: locations));
        emit(ChooseLocation(chosenLocation: chosenLocation));
      } else {
        emit(FetchLocationsError(message: 'There is no locations available'));
      }
    });
  }

  void addNewLocation(String newLocation) {
    emit(AddingNewLocationLoading());

    Future.delayed(Duration(seconds: 1), () {
      List<String> locationStrings = newLocation.split('-');

      final location = LocationItemModel(
        id: DateTime.now().toIso8601String(),
        city: locationStrings[0],
        country: locationStrings[1],
      );

      locations.add(location);
      emit(AddNewLocationSuccess());
    });
  }

  void choseLocation(String locationId) {
    this.locationId = locationId;
    var tempLocation = locations.firstWhere((e) => e.id == locationId);
    emit(ChooseLocation(chosenLocation: tempLocation));
  }

  void confirmLocation() {
    emit(ConfirmLocationLoading());

    var prevChosenLocation = locations.firstWhere((e) => e.isChosen == true);
    var newChosenLocation = locations.firstWhere((e) => e.id == locationId);

    var prevChosenLocationIndex = locations.indexWhere(
      (e) => e.id == prevChosenLocation.id,
    );
    var newChosenLocationIndex = locations.indexWhere(
      (e) => e.id == newChosenLocation.id,
    );

    prevChosenLocation = prevChosenLocation.copyWith(isChosen: false);
    newChosenLocation = newChosenLocation.copyWith(isChosen: true);

    locations[prevChosenLocationIndex] = prevChosenLocation;
    locations[newChosenLocationIndex] = newChosenLocation;

    emit(ConfirmLocationSuccess());
  }
}
