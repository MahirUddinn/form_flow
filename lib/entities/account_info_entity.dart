class AccountInfoEntity {
  final String name;
  final String accountNumber;
  final String? dob;
  final String? imagePath;

  AccountInfoEntity({
    required this.name,
    required this.accountNumber,
    this.dob,
    this.imagePath,
  });

  AccountInfoEntity copyWith({
    String? name,
    String? accountNumber,
    String? dob,
    String? imagePath,
  }) {
    return AccountInfoEntity(
      name: name ?? this.name,
      accountNumber: accountNumber ?? this.accountNumber,
      dob: dob ?? this.dob,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
