import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    super.key,
    required this.onValuesSelected,
    required this.initialValue,
    required this.values,
    required this.validator,
  });

  final void Function(String? relationship) onValuesSelected;
  final String? initialValue;
  final List<String> values;
  final String? Function(String?)? validator;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: DropdownButtonFormField<String>(
        initialValue: _selectedValue,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: "Select a relationship",

          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.people_outline, color: Color(0xFF020202)),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 40,
          ),
        ),
        isExpanded: true,
        icon: const Icon(Icons.arrow_drop_down),
        items: widget.values.map((label) {
          return DropdownMenuItem(
            value: label,
            child: Text(label),
          );
        }).toList(),
        validator: widget.validator,
        onChanged: (value) {
          setState(() {
            _selectedValue = value;
          });
          widget.onValuesSelected(value);
        },
      ),
    );
  }
}