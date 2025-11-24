import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_flow/domain/entities/bank_details_entity.dart';
import 'package:form_flow/presentation/bloc/form_cubit.dart';
import 'package:form_flow/presentation/widget/custom_navigate_button.dart';
import 'package:form_flow/presentation/widget/custom_text_field.dart';

class BankInfoPage extends StatefulWidget {
  const BankInfoPage({super.key, required this.info});

  final BankDetailsEntity info;

  @override
  State<BankInfoPage> createState() => _BankInfoPageState();
}

class _BankInfoPageState extends State<BankInfoPage> {
  final _form = GlobalKey<FormState>();
  final _bankNameController = TextEditingController();
  final _routingNumberController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _cardNumberController = TextEditingController();

  void updateFields() {
    _bankNameController.text = widget.info.bankName;
    _routingNumberController.text = widget.info.routingNumber;
    _phoneNumberController.text = widget.info.phoneNumber;
    _cardNumberController.text = widget.info.cardInfo;
  }

  @override
  void initState() {
    updateFields();
    super.initState();
  }

  @override
  void dispose() {
    _bankNameController.dispose();
    _routingNumberController.dispose();
    _phoneNumberController.dispose();
    _cardNumberController.dispose();
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
        hintText: "Bank Name",
        isObscure: false,
        iconData: Icons.corporate_fare_outlined,
        keyboardType: TextInputType.text,
        validator: (input) {
          if (input == null || input.isEmpty) {
            return "This field can't be empty";
          }
          return null;
        },
        controller: _bankNameController,
      ),
      CustomTextField(
        hintText: "Routing Number",
        isObscure: false,
        iconData: Icons.numbers,
        keyboardType: TextInputType.text,
        validator: (input) {
          if (input == null || input.isEmpty) {
            return "This field can't be empty";
          }
          if (int.tryParse(input) == null) {
            return "Routing number must contain digits only";
          }
          return null;
        },
        controller: _routingNumberController,
      ),
      CustomTextField(
        hintText: "Phone Number",
        isObscure: false,
        iconData: Icons.phone_outlined,
        keyboardType: TextInputType.text,
        validator: (input) {
          if (input == null || input.isEmpty) {
            return "This field can't be empty";
          }
          if (int.tryParse(input) == null) {
            return "Phone number must contain digits only";
          }
          return null;
        },
        controller: _phoneNumberController,
      ),
      CustomTextField(
        hintText: "Card Number",
        isObscure: false,
        iconData: Icons.credit_card,
        keyboardType: TextInputType.text,
        validator: (input) {
          if (input == null || input.isEmpty) {
            return "This field can't be empty";
          }
          if (int.tryParse(input) == null) {
            return "Card number must contain digits only";
          }
          return null;
        },
        controller: _cardNumberController,
      ),

      SizedBox(height: 12),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(width: 8),
              CustomRegisterButton(
                onSubmit: () {
                  context.read<FormCubit>().previousOfBankDetails(
                    BankDetailsEntity(
                      bankName: _bankNameController.text,
                      routingNumber: _routingNumberController.text,
                      phoneNumber: _phoneNumberController.text,
                      cardInfo: _cardNumberController.text,
                    ),
                  );
                },
                text: "<- Previous Page",
              ),
            ],
          ),

          Row(
            children: [
              CustomRegisterButton(
                onSubmit: () {
                  if (_form.currentState!.validate()) {
                    context.read<FormCubit>().nextOfBankDetails(
                      BankDetailsEntity(
                        bankName: _bankNameController.text,
                        routingNumber: _routingNumberController.text,
                        phoneNumber: _phoneNumberController.text,
                        cardInfo: _cardNumberController.text,
                      ),
                    );
                  }
                },
                text: "Next Page ->",
              ),
              SizedBox(width: 8),
            ],
          ),
        ],
      ),
    ];
  }
}
