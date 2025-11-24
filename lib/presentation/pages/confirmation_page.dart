import 'package:flutter/material.dart';
import 'package:form_flow/presentation/bloc/form_cubit.dart';
import 'package:form_flow/presentation/widget/custom_navigate_button.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: Lottie.asset(
              "assets/Verify.json",
              repeat: false,
              width: 200,
              height: 200,
            ),
          ),
          Text(
            "Saved",
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(color: Color(0xFF0793EB), fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20,),
          CustomRegisterButton(
            onSubmit: () {
              context.read<FormCubit>().onReset();
            },
            text: "Return to form",
          ),
        ],
      ),
    );
  }
}
