import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_editor_app/providers/image_provider.dart';
import 'package:provider/provider.dart';

Future<void> getImage(BuildContext context, ImageSource source) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: source);
  if (pickedFile != null) {
    Provider.of<ImageProviderModel>(context, listen: false)
        .loadImage(File(pickedFile.path));
  }
}
