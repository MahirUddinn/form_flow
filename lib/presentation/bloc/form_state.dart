part of 'form_cubit.dart';

enum FormFlow { account, bank, nominee, receipt , confirm}

class FormStatee{
  AccountInfoEntity accountData;
  BankDetailsEntity bankData;
  NomineeInfoEntity nomineeData;
  bool isAuthenticating;
  FormFlow status;

  FormStatee({
    required this.isAuthenticating,
    required this.status,
    required this.accountData,
    required this.bankData,
    required this.nomineeData,
  });

  FormStatee copyWith({
    AccountInfoEntity? accountData,
    BankDetailsEntity? bankData,
    bool? isAuthenticating,
    FormFlow? status,
    NomineeInfoEntity? nomineeData

  }) {
    return FormStatee(
      accountData: accountData ?? this.accountData,
      bankData:  bankData ?? this.bankData,
      nomineeData: nomineeData ?? this.nomineeData,
      isAuthenticating: isAuthenticating ?? this.isAuthenticating,
      status: status ?? this.status,
    );
  }
}
