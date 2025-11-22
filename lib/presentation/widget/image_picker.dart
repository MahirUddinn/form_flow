import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onTapImage});

  final void Function(File image) onTapImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (pickedImage == null) return;

    final imageFile = File(pickedImage.path);

    setState(() {
      _selectedImage = imageFile;
    });

    widget.onTapImage(imageFile);
  }

  @override
  Widget build(BuildContext context) {
    final content = (_selectedImage == null)
        ? TextButton.icon(
      onPressed: _takePicture,
      icon: const Icon(Icons.camera_alt),
      label: const Text("Take Picture"),
    )
        : GestureDetector(
      onTap: _takePicture,
      child: Image.file(
        _selectedImage!,
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );

    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 1,
        ),
      ),
      child: Center(child: content),
    );
  }
}
