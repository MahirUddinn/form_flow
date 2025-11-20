import 'package:flutter/material.dart';
import 'package:form_flow/presentation/bloc/form_cubit.dart';
import 'package:form_flow/presentation/pages/account_info_page.dart';
import 'package:form_flow/presentation/pages/bank_info_page.dart';
import 'package:form_flow/presentation/pages/root_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormFlow extends StatelessWidget {
  FormFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Form flow test',
      home: BlocProvider(
        create: (context) => FormCubit(),
        child: RootPage(),
      ),
    );
  }
}
