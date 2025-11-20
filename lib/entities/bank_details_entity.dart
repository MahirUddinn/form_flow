class BankDetailsEntity {
  final String bankName;
  final String routingNumber;
  final String phoneNumber;
  final String cardInfo;

  BankDetailsEntity({
    required this.bankName,
    required this.routingNumber,
    required this.phoneNumber,
    required this.cardInfo,
  });

  BankDetailsEntity copyWith({
    String? bankName,
    String? routingNumber,
    String? phoneNumber,
    String? cardInfo,
  }) {
    return BankDetailsEntity(
      bankName: bankName ?? this.bankName,
      routingNumber: routingNumber ?? this.routingNumber,
      phoneNumber: phoneNumber ?? this.routingNumber,
      cardInfo: cardInfo ?? this.cardInfo,
    );
  }
}
