import 'package:flutter/material.dart';
import 'package:form_flow/entities/account_info_entity.dart';
import 'package:form_flow/presentation/bloc/form_cubit.dart';
import 'package:form_flow/presentation/widget/custom_navigate_button.dart';
import 'package:form_flow/presentation/widget/custom_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountInfoPage extends StatefulWidget {
  const AccountInfoPage({super.key, required this.info});

  final AccountInfoEntity info;

  @override
  State<AccountInfoPage> createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage> {

  final _form = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _accountNumberController = TextEditingController();

  void updateFields(){
    _nameController.text = widget.info.name;
    _accountNumberController.text = widget.info.accountNumber;
}

  @override
  void initState() {
    updateFields();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _accountNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Center(
      child: Form(
        key: _form,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: width * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildInputForms(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildInputForms(BuildContext context) {
    return [
      CustomTextField(
        hintText: "Name",
        isObscure: false,
        iconData: Icons.person_outline,
        keyboardType: TextInputType.text,
        validator: (input) {
          if (input == null || input.isEmpty) {
            return "This field can't be empty";
          }
          return null;
        },
        controller: _nameController,
      ),
      CustomTextField(
        hintText: "Account Number",
        isObscure: false,
        iconData: Icons.numbers,
        keyboardType: TextInputType.text,
        validator: (input) {
          if (input == null || input.isEmpty) {
            return "This field can't be empty";
          }
          if (int.tryParse(input) == null) {
            return "Account number must contain digits only";
          }
          return null;
        },
        controller: _accountNumberController,
      ),



      SizedBox(height: 12),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomRegisterButton(
            onSubmit: () {
              if(_form.currentState!.validate()){
                context.read<FormCubit>().nextOfAccountInfo(
                  AccountInfoEntity(
                    name: _nameController.text,
                    accountNumber: _accountNumberController.text,
                  ),
                );
              }
            },
            text: "Next Page ->",
          ),
          SizedBox(width: 8),
        ],
      ),
    ];
  }
}
