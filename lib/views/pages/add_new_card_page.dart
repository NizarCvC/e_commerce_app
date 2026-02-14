import 'package:e_commerce_app/view_models/payment_method_cubit/payment_method_cubit.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets/label_with_text_field.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewCardPage extends StatefulWidget {
  const AddNewCardPage({super.key});

  @override
  State<AddNewCardPage> createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCardPage> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Widget _buildAddCardButton(BuildContext context) {
    final cubit = BlocProvider.of<PaymentMethodCubit>(context);
    return BlocConsumer<PaymentMethodCubit, PaymentMethodState>(
      bloc: cubit,
      listenWhen: (previous, current) =>
          current is AddNewCardSuccess || current is AddNewCardError,
      listener: (context, state) {
        if (state is AddNewCardSuccess) {
          Navigator.pop(context);
        } else if (state is AddNewCardError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      buildWhen: (previous, current) =>
          current is AddNewCardLoading ||
          current is AddNewCardSuccess ||
          current is AddNewCardError,
      builder: (context, state) {
        if (state is AddNewCardLoading) {
          return SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: null,
              child: const CircularProgressIndicator.adaptive(),
            ),
          );
        } else if (state is AddNewCardSuccess) {
          return SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: null,
              child: Text('Card Added Successfully'),
            ),
          );
        } else {
          return SizedBox(
            width: double.infinity,
            child: MainButton(
              title: 'Add Card',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  cubit.addNewCard(
                    _cardNumberController.text,
                    _cardHolderNameController.text,
                    _expiryDateController.text,
                    _cvvController.text,
                  );
                }
              },
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Card'),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: .start,
              children: [
                LabelWithTextField(
                  context: context,
                  controller: _cardNumberController,
                  title: 'Card Number',
                  hintText: 'Enter Card Number',
                  prefixIcon: Icon(Icons.credit_card, color: Colors.grey),
                ),
                SizedBox(height: size.height * 0.02),
                LabelWithTextField(
                  context: context,
                  controller: _cardHolderNameController,
                  title: 'Card Holder Name',
                  hintText: 'Enter Holder Name',
                  prefixIcon: Icon(Icons.person_outline, color: Colors.grey),
                ),
                SizedBox(height: size.height * 0.02),
                LabelWithTextField(
                  context: context,
                  controller: _expiryDateController,
                  title: 'Expired',
                  hintText: 'MM/YY',
                  prefixIcon: Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                LabelWithTextField(
                  context: context,
                  controller: _cvvController,
                  title: 'CVV Code',
                  hintText: 'CVV',
                  prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
                ),
                Spacer(),
                _buildAddCardButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
