import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_editor_app/providers/image_provider.dart';
import 'package:photo_editor_app/providers/theme_provider.dart';
import 'package:photo_editor_app/widgets/custom_screen_body.dart';
import 'package:photo_editor_app/widgets/pick_photo.dart';
import 'package:provider/provider.dart';

class ImageEditorScreen extends StatelessWidget {
  final picker = ImagePicker();

  ImageEditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Editor'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          )
        ],
      ),
      body: Consumer<ImageProviderModel>(
        // استخدام Consumer لمتابعة التغييرات
        builder: (context, imageProvider, child) {
          return CustomScreenBody();
        },
      ),
      floatingActionButton: const PickPhoto(), // زر لاختيار الصور
    );
  }
}
