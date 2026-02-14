import 'package:e_commerce_app/models/location_item_model.dart';
import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/view_models/choose_location_cubit/choose_location_cubit.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets/main_button.dart';
import 'package:e_commerce_app/views/widgets/add_new_address_widgets/location_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseLocationPage extends StatefulWidget {
  const ChooseLocationPage({super.key});

  @override
  State<ChooseLocationPage> createState() => _ChooseLocationPageState();
}

class _ChooseLocationPageState extends State<ChooseLocationPage> {
  final TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<ChooseLocationCubit>(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, title: Text('Address')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SizedBox(height: size.height * 0.01),
              Text(
                'Choose your location',
                style: textTheme.headlineSmall!.copyWith(fontWeight: .w600),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                'Let\'s find your unforgettable event. Choose a location below to get started.',
                style: textTheme.titleSmall!.copyWith(color: Colors.grey[500]),
              ),
              SizedBox(height: size.height * 0.03),
              BlocConsumer<ChooseLocationCubit, ChooseLocationState>(
                listenWhen: (previous, current) =>
                    current is AddNewLocationSuccess,
                listener: (context, state) {
                  if (state is AddNewLocationSuccess) {
                    _locationController.clear();
                  }
                },
                bloc: cubit,
                buildWhen: (previous, current) =>
                    current is AddNewLocationSuccess ||
                    current is AddingNewLocationLoading ||
                    current is AddingLocationError,
                builder: (context, state) {
                  if (state is AddingNewLocationLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  return TextField(
                    controller: _locationController,
                    decoration: InputDecoration(
                      hintText: 'Your address city-country',
                      filled: true,
                      fillColor: Colors.grey[100],
                      prefixIcon: Icon(
                        Icons.pin_drop_outlined,
                        color: Colors.grey[600],
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 2.0),
                        child: IconButton(
                          onPressed: () {
                            if (_locationController.text.isNotEmpty) {
                              cubit.addNewLocation(_locationController.text);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Enter your location')),
                              );
                            }
                          },
                          icon: Icon(
                            Icons.add_location_alt_outlined,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: .none,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                'Select location',
                style: textTheme.headlineSmall!.copyWith(fontWeight: .w600),
              ),
              SizedBox(
                height: size.height * 0.5,
                width: double.infinity,
                child: BlocConsumer<ChooseLocationCubit, ChooseLocationState>(
                  listenWhen: (previous, current) =>
                      current is AddNewLocationSuccess,
                  listener: (context, state) {
                    if (state is AddNewLocationSuccess) {
                      cubit.fetchLocations();
                    }
                  },
                  bloc: cubit,
                  buildWhen: (previous, current) =>
                      current is FetchingLocations ||
                      current is FetchedLocations ||
                      current is FetchLocationsError ||
                      current is AddNewLocationSuccess,
                  builder: (context, state) {
                    if (state is FetchingLocations) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else if (state is FetchedLocations) {
                      final fetchedLocations = state.fetchedLocations;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: locations.length,
                        itemBuilder: (context, index) {
                          final locationModel = fetchedLocations[index];
                          return BlocBuilder<
                            ChooseLocationCubit,
                            ChooseLocationState
                          >(
                            bloc: cubit,
                            buildWhen: (previous, current) =>
                                current is ChooseLocation,
                            builder: (context, state) {
                              if (state is ChooseLocation) {
                                final chosenLocation = state.chosenLocation;
                                return LocationItem(
                                  onTap: () {
                                    cubit.choseLocation(locationModel.id);
                                  },
                                  locationModel: locationModel,
                                  borderColor:
                                      chosenLocation.id == locationModel.id
                                      ? AppColors.primary
                                      : Colors.grey,
                                );
                              }
                              return LocationItem(
                                onTap: () {
                                  cubit.choseLocation(locationModel.id);
                                },
                                locationModel: locationModel,
                              );
                            },
                          );
                        },
                      );
                    } else if (state is FetchLocationsError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: Theme.of(context).textTheme.headlineLarge!
                              .copyWith(color: Colors.red),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
              Spacer(),
              BlocConsumer<ChooseLocationCubit, ChooseLocationState>(
                bloc: cubit,
                listener: (context, state) {
                  if (state is ConfirmLocationSuccess) {
                    Navigator.pop(context);
                  }
                },
                buildWhen: (previous, current) =>
                    current is ConfirmLocationLoading ||
                    current is ConfirmLocationSuccess ||
                    current is ConfirmLocationError,
                builder: (context, state) {
                  if (state is ConfirmLocationLoading) {
                    return MainButton(
                      onPressed: () {
                        cubit.confirmLocation();
                      },
                      isLoading: true,
                    );
                  }
                  return MainButton(
                    title: 'Confirm Address',
                    onPressed: () {
                      cubit.confirmLocation();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
