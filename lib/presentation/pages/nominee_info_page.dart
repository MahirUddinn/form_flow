import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_flow/entities/nominee_info_entity.dart';
import 'package:form_flow/presentation/bloc/form_cubit.dart';
import 'package:form_flow/presentation/widget/custom_navigate_button.dart';
import 'package:form_flow/presentation/widget/custom_text_field.dart';

class NomineeInfoPage extends StatefulWidget {
  const NomineeInfoPage({super.key, required this.info});

  final NomineeInfoEntity info;

  @override
  State<NomineeInfoPage> createState() => _NomineeInfoPageState();
}

class _NomineeInfoPageState extends State<NomineeInfoPage> {
  final _form = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _relationshipController = TextEditingController();
  final _ownerShipPercentageController = TextEditingController();

  void updateFields() {
    _nameController.text = widget.info.nomineeName;
    _relationshipController.text = widget.info.relationShip;
    _ownerShipPercentageController.text = widget.info.ownership;
  }

  @override
  void initState() {
    updateFields();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _relationshipController.dispose();
    _ownerShipPercentageController.dispose();
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
        hintText: "Nominee name",
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
        hintText: "Relationship",
        isObscure: false,
        iconData: Icons.people_outline,
        keyboardType: TextInputType.text,
        validator: (input) {
          if (input == null || input.isEmpty) {
            return "This field can't be empty";
          }
          return null;
        },
        controller: _relationshipController,
      ),
      CustomTextField(
        hintText: "Ownership Percentage",
        isObscure: false,
        iconData: Icons.percent,
        keyboardType: TextInputType.number,
        validator: (input) {
          if (input == null || input.isEmpty) {
            return "This field can't be empty";
          }
          if (int.tryParse(input) == null) {
            return "Percentage must contain digits only";
          }
          if (int.tryParse(input)! > 100) {
            return "Percentage must be within 100";
          }
          return null;
        },
        controller: _ownerShipPercentageController,
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
                  context.read<FormCubit>().previousOfNomineeInfo(
                    NomineeInfoEntity(
                      nomineeName: _nameController.text,
                      relationShip: _relationshipController.text,
                      ownership: _ownerShipPercentageController.text,
                    ),
                  );
                },
                text: "<- Previous Page",
              ),
            ],
          ),

          Row(
            children: [
              BlocBuilder<FormCubit, FormStatee>(
                builder: (context, state) {
                  if (state.isAuthenticating) {
                    return CircularProgressIndicator();
                  } else {
                    return CustomRegisterButton(
                      onSubmit: () {
                        // if (_form.currentState!.validate()) {
                          context.read<FormCubit>().register(
                            NomineeInfoEntity(
                              nomineeName: _nameController.text,
                              relationShip: _relationshipController.text,
                              ownership: _ownerShipPercentageController.text,
                            ),
                          );
                        // }
                      },
                      text: "Register",
                    );
                  }
                },
              ),
              SizedBox(width: 8),
            ],
          ),
        ],
      ),
    ];
  }
}
