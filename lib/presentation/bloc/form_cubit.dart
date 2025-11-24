
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_flow/entities/account_info_entity.dart';
import 'package:form_flow/entities/bank_details_entity.dart';
import 'package:form_flow/entities/nominee_info_entity.dart';
import 'package:path_provider/path_provider.dart';
part 'form_state.dart';

class FormCubit extends Cubit<FormStatee> {
  FormCubit()
    : super(
        FormStatee(
          accountData: AccountInfoEntity(
            name: "",
            accountNumber: "",
            dob: "",
            imagePath: "",
          ),
          bankData: BankDetailsEntity(
            bankName: "",
            routingNumber: "",
            phoneNumber: "",
            cardInfo: "",
          ),
          nomineeData: NomineeInfoEntity(
            nomineeName: "",
            relationShip: "",
            ownership: "",
          ),
          isAuthenticating: false,
          status: FormFlow.account,
        ),
      );

  void nextOfAccountInfo(AccountInfoEntity value) =>
      emit(state.copyWith(accountData: value, status: FormFlow.bank));

  void previousOfBankDetails(BankDetailsEntity value) =>
      emit(state.copyWith(bankData: value, status: FormFlow.account));

  void nextOfBankDetails(BankDetailsEntity value) =>
      emit(state.copyWith(bankData: value, status: FormFlow.nominee));

  void previousOfNomineeInfo(NomineeInfoEntity value) =>
      emit(state.copyWith(nomineeData: value, status: FormFlow.bank));

  void register(NomineeInfoEntity value) async {
    emit(
      state.copyWith(
        nomineeData: value,
        isAuthenticating: true,
        status: FormFlow.receipt,
      ),
    );

    await Future.delayed(const Duration(seconds: 2));

    print("===== ACCOUNT INFO =====");
    print("Name: ${state.accountData.name}");
    print("Account Number: ${state.accountData.accountNumber}");
    print("Date of Birth: ${state.accountData.dob}");
    print("Image Path: ${state.accountData.imagePath}");

    print("===== BANK DETAILS =====");
    print("Bank Name: ${state.bankData.bankName}");
    print("Routing Number: ${state.bankData.routingNumber}");
    print("Phone Number: ${state.bankData.phoneNumber}");
    print("Card Info: ${state.bankData.cardInfo}");

    print("===== NOMINEE INFO =====");
    print("Nominee Name: ${value.nomineeName}");
    print("Relationship: ${value.relationShip}");
    print("Ownership: ${value.ownership}");

    emit(state.copyWith(isAuthenticating: false));
  }

  void onSave(Uint8List imageBytes)async{
    emit(state.copyWith(isAuthenticating: true));
    final Directory? dir = await getExternalStorageDirectory();
    final String imageDir = dir!.path.split("Android")[0];
    print(imageDir);
    final String folderName = "FormImage";
    final Directory saveDir = Directory("$imageDir$folderName");

    if (!await saveDir.exists()) {
    await saveDir.create();
    }

    final String filePath =
    "${saveDir.path}/image_${DateTime.now().millisecondsSinceEpoch}.png";

    final File file = File(filePath);
    await file.writeAsBytes(imageBytes);

    print("Saved at: $filePath");
    emit(state.copyWith(isAuthenticating: false));

  }
}
