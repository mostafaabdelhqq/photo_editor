import 'package:flutter/material.dart';
import 'package:photo_editor_app/providers/image_provider.dart';
import 'package:photo_editor_app/widgets/editing_option.dart';
import 'package:provider/provider.dart';

class CustomScreenBody extends StatelessWidget {
  const CustomScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageProviderModel>(context);
    return Column(
      children: [
        const Spacer(
          flex: 1,
        ),
        Center(
          child: imageProvider.imageFile == null
              ? const Text('No image selected.')
              : Image.file(imageProvider.imageFile!),
        ),
        const Spacer(
          flex: 2,
        ),
        EditingOption()
      ],
    );
  }
}
