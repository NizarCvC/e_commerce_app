part of 'payment_method_cubit.dart';

sealed class PaymentMethodState {}

final class PaymentMethodInitial extends PaymentMethodState {}

final class AddNewCardLoading extends PaymentMethodState {}

final class AddNewCardSuccess extends PaymentMethodState {}

final class AddNewCardError extends PaymentMethodState {
  final String message;

  AddNewCardError({required this.message});
}

final class FetchingPaymentMethods extends PaymentMethodState {}

final class FetchedPaymentMethods extends PaymentMethodState {
  final List<PaymentCardModel> paymentCards;

  FetchedPaymentMethods({required this.paymentCards});
}

final class FetchPaymentMethodsError extends PaymentMethodState {
  final String message;

  FetchPaymentMethodsError({required this.message});
}

final class ConfirmPaymentLoading extends PaymentMethodState {}

final class ConfirmPaymentSuccess extends PaymentMethodState {}

final class ConfirmPaymentError extends PaymentMethodState {
  final String message;

  ConfirmPaymentError({required this.message});
}

final class PaymentMethodChosen extends PaymentMethodState {
  final PaymentCardModel chosenPayment;

  PaymentMethodChosen({required this.chosenPayment});
}
