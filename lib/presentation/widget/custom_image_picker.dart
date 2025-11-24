import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends StatefulWidget {
  const CustomImagePicker({
    super.key,
    required this.onImagePicked,
    required this.initialImage,
    required this.validator,
  });

  final void Function(File? image) onImagePicked;
  final File? initialImage;
  final String? Function(File?)? validator;

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.initialImage;
  }

  Future<void> _pickImage(FormFieldState<File?> field) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (picked == null) return;

    final file = File(picked.path);

    setState(() {
      _selectedImage = file;
    });

    field.didChange(file);

    widget.onImagePicked(file);
  }

  @override
  Widget build(BuildContext context) {
    return FormField<File?>(
      validator: widget.validator,
      initialValue: _selectedImage,
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
                onTap: () => _pickImage(field),
                title: Row(
                  children: [
                    Icon(Icons.image),
                    SizedBox(width: 13),

                    if (_selectedImage == null)
                      Opacity(opacity: 0.8, child: Text("Select an image"))
                    else
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Image selected"),
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),

            if (hasError)
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 4),
                child: Text(
                  field.errorText!,
                  style: TextStyle(color: Colors.red[900], fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
