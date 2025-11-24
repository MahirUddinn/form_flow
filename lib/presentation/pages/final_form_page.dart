import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_flow/presentation/bloc/form_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_flow/presentation/widget/custom_navigate_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class FinalFormPage extends StatelessWidget {
  FinalFormPage({super.key});

  final ScreenshotController screenshotController = ScreenshotController();

  Future<bool> requestStorageAccess() async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      return true;
    }

    final img = await Permission.photos.request();
    final vid = await Permission.videos.request();
    final aud = await Permission.audio.request();

    if (img.isGranted || vid.isGranted || aud.isGranted) {
      return true;
    }

    if (img.isPermanentlyDenied ||
        vid.isPermanentlyDenied ||
        aud.isPermanentlyDenied) {
      openAppSettings();
    }

    return false;
  }

  Future<void> _saveImage(BuildContext context, FormStatee state) async {
    if (!await requestStorageAccess()) {
      print("Permission denied");
      return;
    }

    final Uint8List imageBytes = await screenshotController.captureFromWidget(
      _finalInfo(context, state),
      delay: Duration(milliseconds: 100),
      pixelRatio: 3.0,

    );

    context.read<FormCubit>().onSave(imageBytes);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormCubit, FormStatee>(
      builder: (context, state) {
        return Column(
          children: [
            Screenshot(
              controller: screenshotController,
              child: _finalInfo(context, state),
            ),
            CustomRegisterButton(
              onSubmit: () {
                _saveImage(context, state);
              },
              text: "Save",
            ),
          ],
        );
      },
    );
  }

  Widget _finalInfo(BuildContext context, FormStatee state) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(height: 250, child: _accountInfo(context, state)),
            SizedBox(height: 200, child: _bankInfo(context, state)),
            SizedBox(height: 200, child: _nomineeInfo(context, state)),
          ],
        ),
      ),
    );
  }

  Widget _bankInfo(BuildContext context, FormStatee state) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Center(
            child: Text(
              "Bank Info",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _customText(context, "Bank Name", state.bankData.bankName),
                  _customText(
                    context,
                    "Phone Name",
                    state.bankData.phoneNumber,
                  ),
                  _customText(
                    context,
                    "Routing Name",
                    state.bankData.routingNumber,
                  ),
                  _customText(context, "Card Info", state.bankData.cardInfo),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _nomineeInfo(BuildContext context, FormStatee state) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Center(
            child: Text(
              "Nominee Info",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _customText(
                    context,
                    "Nominee Name",
                    state.nomineeData.nomineeName,
                  ),
                  _customText(
                    context,
                    "Relationship",
                    state.nomineeData.relationShip,
                  ),
                  _customText(
                    context,
                    "Ownership",
                    state.nomineeData.ownership,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _accountInfo(BuildContext context, FormStatee state) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Center(
            child: Text(
              "Account Info",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _customText(context, "Name", state.accountData.name),
                  _customText(
                    context,
                    "Account Number",
                    state.accountData.accountNumber,
                  ),
                  _customText(context, "Date of Birth", state.accountData.dob),
                ],
              ),
              SizedBox(
                width: 90,
                height: 160,
                child: Image.file(
                  File(state.accountData.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _customText(BuildContext context, String title, String desc) {
    return RichText(
      text: TextSpan(
        text: "$title: ",
        style: Theme.of(context).textTheme.titleMedium,
        children: [
          TextSpan(text: desc, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
