import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_editor_app/methods/get_image.dart';

class PickPhoto extends StatelessWidget {
  const PickPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => getImage(context, ImageSource.camera),
            tooltip: 'Pick Image from Camera',
            heroTag: 'uniqueTag1',
            child: const Icon(Icons.camera_alt),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => getImage(context, ImageSource.gallery),
            tooltip: 'Pick Image from Gallery',
            heroTag: 'uniqueTag2',
            child: const Icon(Icons.photo_library),
          ),
        ],
      ),
    );
  }
}
