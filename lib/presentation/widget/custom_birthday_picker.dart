import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomBirthdayPicker extends StatelessWidget {
  const CustomBirthdayPicker({
    super.key,
    required this.onTap,
    required this.selectedDate,
    required this.formatter,
    required this.validator,
  });

  final VoidCallback onTap;
  final DateTime? selectedDate;
  final DateFormat formatter;
  final String? Function(Object?)? validator;

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      validator: validator,
      builder: (field) {
        final hasError = field.hasError;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.hardEdge,
              child: ListTile(
                onTap: onTap,
                title: Row(
                  children: [
                    Icon(Icons.calendar_month),
                    SizedBox(width: 13),
                    (selectedDate == null)
                        ? Opacity(
                      opacity: 0.8,
                      child: Text("Select your birthday"),
                    )
                        : Text(formatter.format(selectedDate!)),
                  ],
                ),
              ),
            ),

            if (hasError)
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 4),
                child: Text(
                  field.errorText!,
                  style: TextStyle(
                    color: Colors.red[900],
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
