import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isObscure;
  final IconData? iconData;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.isObscure = false,
    this.iconData,
    this.keyboardType,
    this.validator,
    this.onSaved,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        controller: controller ?? TextEditingController(),
        obscureText: isObscure,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: hintText,

          prefixIcon: iconData != null
              ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Icon(iconData, color: const Color(0xFF020202)),
          )
              : null,

          prefixIconConstraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 40,
          ),
        ),
        textCapitalization: TextCapitalization.none,
        autocorrect: false,
        keyboardType: keyboardType,
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
