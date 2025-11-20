class AccountInfoEntity {
  final String name;
  final String accountNumber;

  AccountInfoEntity({required this.name, required this.accountNumber});

  AccountInfoEntity copyWith({String? name, String? accountNumber}) {
    return AccountInfoEntity(
      name: name ?? this.name,
      accountNumber: accountNumber ?? this.accountNumber,
    );
  }
}
