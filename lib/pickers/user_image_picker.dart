import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker(this.imagePickedfn, {Key? key}) : super(key: key);

  final void Function(File pickedImage) imagePickedfn;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageCam() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    Navigator.of(context).pop();
    // print(image!.path.toString());
    setState(() {
      _pickedImage = File(image!.path);
    });
    widget.imagePickedfn(File(image!.path));
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    Navigator.of(context).pop();
    // print(image!.path.toString());
    setState(() {
      _pickedImage = File(image!.path);
    });
    widget.imagePickedfn(File(image!.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
          radius: 40,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      elevation: 16,
                      child: SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton.icon(
                              onPressed: _pickImageCam,
                              icon: const Icon(Icons.camera),
                              label: const Text('Camera'),
                            ),
                            TextButton.icon(
                              onPressed: _pickImage,
                              icon: const Icon(Icons.image),
                              label: const Text('Gallery'),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: const Text('Add Image'))
      ],
    );
  }
}
