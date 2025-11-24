class NomineeInfoEntity {
  final String nomineeName;
  final String relationShip;
  final String ownership;

  NomineeInfoEntity({
    required this.nomineeName,
    required this.relationShip,
    required this.ownership,
  });

  NomineeInfoEntity copyWith({
    String? nomineeName,
    String? relationShip,
    String? ownership,
  }) {
    return NomineeInfoEntity(
      nomineeName: nomineeName ?? this.nomineeName,
      relationShip: relationShip ?? this.relationShip,
      ownership: ownership ?? this.relationShip,
    );
  }
}
