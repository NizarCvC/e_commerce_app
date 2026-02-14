class PaymentCardModel {
  final String id;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvv;
  final bool isChosen;

  PaymentCardModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv,
    this.isChosen = false,
  });

  PaymentCardModel copyWith({
    String? id,
    String? cardNumber,
    String? cardHolderName,
    String? expiryDate,
    String? cvv,
    bool? isChosen,
  }) {
    return PaymentCardModel(
      id: id ?? this.id,
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
      isChosen: isChosen ?? this.isChosen,
    );
  }
}

List<PaymentCardModel> paymentCards = [
  PaymentCardModel(
    id: '1',
    cardNumber: '**** **** **** 1234',
    cardHolderName: 'Nizar Omar',
    expiryDate: '12/24',
    cvv: '123',
    isChosen: true,
  ),
  PaymentCardModel(
    id: '2',
    cardNumber: '**** **** **** 5678',
    cardHolderName: 'John Doe',
    expiryDate: '11/23',
    cvv: '456',
  ),
  PaymentCardModel(
    id: '3',
    cardNumber: '**** **** **** 9012',
    cardHolderName: 'Jane Smith',
    expiryDate: '10/25',
    cvv: '789',
  ),
];
