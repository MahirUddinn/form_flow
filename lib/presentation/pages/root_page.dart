import 'package:flutter/material.dart';
import 'package:form_flow/presentation/bloc/form_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_flow/presentation/pages/account_info_page.dart';
import 'package:form_flow/presentation/pages/bank_info_page.dart';
import 'package:form_flow/presentation/pages/confirmation_page.dart';
import 'package:form_flow/presentation/pages/final_form_page.dart';
import 'package:form_flow/presentation/pages/nominee_info_page.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDEDED),
      appBar: AppBar(backgroundColor: Color(0xFFEDEDED),),
      body: BlocBuilder<FormCubit, FormStatee>(
        builder: (context, state) {
          if(state.status == FormFlow.account){
            return AccountInfoPage(info: state.accountData);
          }
          if(state.status == FormFlow.bank){
            return BankInfoPage(info: state.bankData,);
          }
          if(state.status == FormFlow.nominee){
            return NomineeInfoPage(info: state.nomineeData,);
          }
          if(state.status == FormFlow.receipt){
            return FinalFormPage();
          }
          if(state.status == FormFlow.confirm){
            return ConfirmationPage();
          }
          return Container();
        },
      ),
    );
  }
}
