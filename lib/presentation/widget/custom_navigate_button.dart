import 'package:flutter/material.dart';

class CustomRegisterButton extends StatelessWidget {
  const CustomRegisterButton({
    super.key,
    required this.onSubmit,
    required this.text,
  });

  final VoidCallback onSubmit;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSubmit,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xFF0793EB),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
