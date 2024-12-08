import 'package:flutter/material.dart';
import 'package:photo_editor_app/providers/image_provider.dart';
import 'package:provider/provider.dart';

class EditingOption extends StatelessWidget {
  const EditingOption({super.key});

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageProviderModel>(context);
    final hasImage = imageProvider.imageFile != null;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.filter, color: Colors.blue),
              onPressed: hasImage
                  ? () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              children: [
                                const Text(
                                  'Choose a Filter',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ListTile(
                                  leading: const Icon(Icons.filter),
                                  title: const Text('Sobel Filter'),
                                  onTap: () {
                                    imageProvider.selectFilter('Sobel');
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.filter),
                                  title: const Text('Laplacian Filter'),
                                  onTap: () {
                                    imageProvider.selectFilter('Laplacian');
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.filter),
                                  title: const Text('Smoothing Filter'),
                                  onTap: () {
                                    imageProvider.selectFilter('Smoothing');
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.filter),
                                  title: const Text(
                                      'Neighbourhood Average Filter'),
                                  onTap: () {
                                    imageProvider
                                        .selectFilter('Neighbourhood Average');
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  : null,
            ),
            IconButton(
              icon: Icon(Icons.save,
                  color: hasImage ? Colors.green : Colors.grey),
              onPressed: hasImage
                  ? () async {
                      await imageProvider.saveEditedImage(context);
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
