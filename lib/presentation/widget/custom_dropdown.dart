import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    super.key,
    required this.onValuesSelected,
    required this.initialValue,
    required this.values,
  });

  final void Function(String? relationship) onValuesSelected;
  final String? initialValue;
  final List<String> values;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _selectedRelationship;

  @override
  void initState() {
    super.initState();
    _selectedRelationship = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.people_outline, color: Color(0xFF020202)),
          ),
          prefixIconConstraints: BoxConstraints(minWidth: 40, minHeight: 40),
        ),
        hint: Text("Select a relationship"),
        initialValue: _selectedRelationship,
        items: widget.values
            .map((label) => DropdownMenuItem(value: label, child: Text(label)))
            .toList(),
        onChanged: (value) {
          setState(() {
            _selectedRelationship = value;
          });
          widget.onValuesSelected(value);
        },
      ),
    );
  }
}
