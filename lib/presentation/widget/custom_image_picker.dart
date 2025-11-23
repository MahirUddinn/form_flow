import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends StatefulWidget {
  const CustomImagePicker({
    super.key,
    required this.onImagePicked,
    required this.initialImage,
  });

  final void Function(File? image) onImagePicked;
  final File? initialImage;

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

  void _imagePicker() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (pickedImage == null) return;

    final imageFile = File(pickedImage.path);

    setState(() {
      _selectedImage = imageFile;
    });
    widget.onImagePicked(_selectedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        onTap: _imagePicker,
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
                    Container(
                      width: 40,
                      height: 40,
                      child: Image.file(_selectedImage!, fit: BoxFit.cover),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
