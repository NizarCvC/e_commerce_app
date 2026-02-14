import 'package:e_commerce_app/models/payment_card_model.dart';
import 'package:e_commerce_app/utils/app_assets.dart';
import 'package:e_commerce_app/utils/app_routes.dart';
import 'package:e_commerce_app/view_models/payment_method_cubit/payment_method_cubit.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodBottomSheet extends StatefulWidget {
  const PaymentMethodBottomSheet({super.key});

  @override
  State<PaymentMethodBottomSheet> createState() =>
      _PaymentMethodBottomSheetState();
}

class _PaymentMethodBottomSheetState extends State<PaymentMethodBottomSheet> {
  Widget _buildPaymentMethodItem(
    BuildContext context,
    PaymentCardModel paymentCard,
    PaymentMethodCubit cubit,
  ) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<PaymentMethodCubit, PaymentMethodState>(
      bloc: cubit,
      buildWhen: (previous, current) => current is PaymentMethodChosen,
      builder: (context, state) {
        if (state is PaymentMethodChosen) {
          final chosenPaymentMethod = state.chosenPayment;
          return RadioGroup(
            groupValue: chosenPaymentMethod.id,
            onChanged: (id) {
              cubit.choosePaymentMethod(id!);
            },
            child: SizedBox(
              width: double.infinity,
              height: size.height * 0.11,
              child: Card(
                color: Colors.white,
                elevation: 0,
                child: Align(
                  alignment: .center,
                  child: ListTile(
                    leading: Image.asset(
                      AppAssets.masterCardImage,
                      height: size.height * 0.04,
                      fit: .cover,
                    ),
                    title: Text('Master Card', style: textTheme.titleMedium),
                    subtitle: Text(
                      paymentCard.cardNumber,
                      style: textTheme.titleMedium!.copyWith(
                        color: Colors.grey[500],
                      ),
                    ),
                    trailing: Radio<String>(value: paymentCard.id),
                  ),
                ),
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildAddPaymentMethodItem(
    BuildContext context,
    PaymentMethodCubit cubit,
  ) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      color: Colors.white,
      elevation: 0,
      child: Align(
        alignment: .center,
        child: ListTile(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(AppRoutes.addNewCardPageRoute)
                  .then((onValue) => cubit.fetchPaymentMethods());
            },
            icon: Icon(Icons.add_circle_outline_rounded),
          ),
          title: Text('Add Payment Method', style: textTheme.titleMedium),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final cubit = BlocProvider.of<PaymentMethodCubit>(context);
    return BlocBuilder<PaymentMethodCubit, PaymentMethodState>(
      bloc: cubit,
      buildWhen: (previous, current) =>
          current is FetchingPaymentMethods ||
          current is FetchedPaymentMethods ||
          current is FetchPaymentMethodsError,
      builder: (context, state) {
        if (state is FetchingPaymentMethods) {
          return SizedBox(
            height: size.height * 0.45,
            width: double.infinity,
            child: Center(child: CircularProgressIndicator.adaptive()),
          );
        } else if (state is FetchedPaymentMethods) {
          final paymentCards = state.paymentCards;
          return SafeArea(
            child: SizedBox(
              height: size.height * 0.45,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text('Payment Method', style: textTheme.titleLarge),
                    SizedBox(height: size.height * 0.01),
                    SizedBox(
                      height: size.height * 0.25,
                      child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        itemCount: paymentCards.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            _buildPaymentMethodItem(
                              context,
                              paymentCards[index],
                              cubit,
                            ),
                      ),
                    ),
                    Spacer(),
                    _buildAddPaymentMethodItem(context, cubit),
                    SizedBox(height: size.height * 0.01),
                    BlocConsumer<PaymentMethodCubit, PaymentMethodState>(
                      bloc: cubit,
                      listener: (context, state) {
                        if (state is ConfirmPaymentSuccess) {
                          Navigator.pop(context);
                        }
                      },
                      listenWhen: (previous, current) =>
                          current is ConfirmPaymentSuccess,
                      buildWhen: (previous, current) =>
                          current is ConfirmPaymentLoading ||
                          current is ConfirmPaymentSuccess ||
                          current is ConfirmPaymentError,
                      builder: (context, state) {
                        if (state is ConfirmPaymentLoading) {
                          return MainButton(
                            onPressed: () {
                              cubit.confirmPaymentMethod();
                            },
                            isLoading: true,
                          );
                        }
                        return MainButton(
                          title: 'Confirm Payment',
                          onPressed: () {
                            cubit.confirmPaymentMethod();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is FetchPaymentMethodsError) {
          return SizedBox(
            height: size.height * 0.45,
            width: double.infinity,
            child: Center(
              child: Text(
                state.message,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge!.copyWith(color: Colors.red),
              ),
            ),
          );
        } else {
          return SizedBox(
            height: size.height * 0.45,
            width: double.infinity,
            child: const Center(child: Text('Something went wrong!')),
          );
        }
      },
    );
  }
}
