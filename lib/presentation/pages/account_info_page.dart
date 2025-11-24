import 'dart:io';
import 'package:flutter/material.dart';
import 'package:form_flow/entities/account_info_entity.dart';
import 'package:form_flow/presentation/bloc/form_cubit.dart';
import 'package:form_flow/presentation/widget/custom_birthday_picker.dart';
import 'package:form_flow/presentation/widget/custom_navigate_button.dart';
import 'package:form_flow/presentation/widget/custom_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../widget/custom_image_picker.dart';

class AccountInfoPage extends StatefulWidget {
  const AccountInfoPage({super.key, required this.info});

  final AccountInfoEntity info;

  @override
  State<AccountInfoPage> createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage> {
  final _form = GlobalKey<FormState>();
  final formatter = DateFormat.yMd();
  final _nameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  DateTime? _selectedDate;
  File? _selectedImage;

  void updateFields() {
    _nameController.text = widget.info.name;
    _accountNumberController.text = widget.info.accountNumber;
    if (widget.info.imagePath.isNotEmpty) {
      _selectedImage = File(widget.info.imagePath);
    }
    if (widget.info.dob.isNotEmpty) {
      _selectedDate = formatter.parse(widget.info.dob);
    }
  }

  void _dayPicker() async {
    final now = DateTime.now();
    final isDate = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 100, now.month, now.day),
      lastDate: DateTime(now.year, now.month, now.day),
    );
    setState(() {
      _selectedDate = isDate;
    });
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
      const SizedBox(height: 4),
      CustomBirthdayPicker(
        validator: (value) {
          if (_selectedDate == null) {
            return "This field can't be empty";
          }
          return null;
        },
        onTap: _dayPicker,
        selectedDate: _selectedDate,
        formatter: formatter,
      ),
      const SizedBox(height: 8),
      CustomImagePicker(
        validator: (value){
          if (value == null) {
            return "This field can't be empty";
          }
          return null;
        },
        initialImage: _selectedImage,
        onImagePicked: (image) {
          setState(() {
            _selectedImage = image;
          });
        },
      ),
      const SizedBox(height: 12),
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
                      dob: _selectedDate != null
                          ? formatter.format(_selectedDate!)
                          : '',
                      imagePath: _selectedImage?.path ?? '',
                    ),
                  );
              }
            },
            text: "Next Page ->",
          ),
          const SizedBox(width: 8),
        ],
      ),
    ];
  }


}

