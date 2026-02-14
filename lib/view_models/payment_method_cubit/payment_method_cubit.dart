import 'package:e_commerce_app/models/payment_card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_method_state.dart';

class PaymentMethodCubit extends Cubit<PaymentMethodState> {
  PaymentMethodCubit() : super(PaymentMethodInitial());

  String chosenPaymentId = paymentCards.first.id;

  void addNewCard(
    String cardNumber,
    String cardHolderName,
    String expiryDate,
    String cvv,
  ) {
    emit(AddNewCardLoading());

    final paymentCard = PaymentCardModel(
      id: DateTime.now().toIso8601String(),
      cardNumber: cardNumber,
      cardHolderName: cardHolderName,
      expiryDate: expiryDate,
      cvv: cvv,
    );

    Future.delayed(Duration(seconds: 2), () {
      paymentCards.add(paymentCard);
      emit(AddNewCardSuccess());
    });
  }

  void fetchPaymentMethods() {
    emit(FetchingPaymentMethods());
    Future.delayed(Duration(seconds: 1), () {
      if (paymentCards.isNotEmpty) {
        final chosenPaymentMethod = paymentCards.firstWhere(
          (e) => e.isChosen == true,
          orElse: () => paymentCards.first,
        );
        emit(FetchedPaymentMethods(paymentCards: paymentCards));
        emit(PaymentMethodChosen(chosenPayment: chosenPaymentMethod));
      } else {
        emit(FetchPaymentMethodsError(message: 'No payment methods exists!'));
      }
    });
  }

  void choosePaymentMethod(String paymentId) {
    chosenPaymentId = paymentId;
    var tempPaymentCard = paymentCards.firstWhere(
      (e) => e.id == chosenPaymentId,
    );
    emit(PaymentMethodChosen(chosenPayment: tempPaymentCard));
  }

  void confirmPaymentMethod() {
    emit(ConfirmPaymentLoading());

    Future.delayed(Duration(seconds: 1), () {
      var prevChosenCard = paymentCards.firstWhere(
        (e) => e.isChosen == true,
        orElse: () => paymentCards.first,
      );
      final prevChosenCardIndex = paymentCards.indexWhere(
        (e) => e.isChosen == true,
      );
      prevChosenCard = prevChosenCard.copyWith(isChosen: false);
      paymentCards[prevChosenCardIndex] = prevChosenCard;

      var chosenPaymentCard = paymentCards.firstWhere(
        (e) => e.id == chosenPaymentId,
      );
      var chosenPaymentCardIndex = paymentCards.indexWhere(
        (e) => e.id == chosenPaymentId,
      );
      chosenPaymentCard = chosenPaymentCard.copyWith(isChosen: true);
      paymentCards[chosenPaymentCardIndex] = chosenPaymentCard;

      emit(ConfirmPaymentSuccess());
    });
  }
}
