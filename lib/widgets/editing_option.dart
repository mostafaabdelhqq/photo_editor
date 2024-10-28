import 'package:flutter/material.dart';
import 'package:photo_editor_app/providers/image_provider.dart';
import 'package:provider/provider.dart';

class EditingOption extends StatelessWidget {
  const EditingOption({super.key});

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageProviderModel>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.filter),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 300,
                      child: ListView(
                        children: [
                          ListTile(
                            title: Text('Sobel Filter'),
                            onTap: () {
                              imageProvider.selectFilter('Sobel');
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text('Laplacian Filter'),
                            onTap: () {
                              imageProvider.selectFilter('Laplacian');
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text('Gaussian Filter'),
                            onTap: () {
                              imageProvider.selectFilter('Gaussian');
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text('Neighbourhood Average Filter'),
                            onTap: () {
                              imageProvider
                                  .selectFilter('Neighbourhood Average');
                              Navigator.pop(context);
                            },
                          ),
                          // Slider للتحكم في قوة الفلتر
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                    'Filter Strength: ${imageProvider.filterStrength.toStringAsFixed(1)}'),
                                Slider(
                                  min: 1,
                                  max: 30,
                                  divisions: 30,
                                  value: imageProvider.filterStrength,
                                  label:
                                      imageProvider.filterStrength.toString(),
                                  onChanged: (double value) {
                                    imageProvider.setFilterStrength(value);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.crop),
              onPressed: () {
                final cropRect = Rect.fromLTWH(100, 100, 300, 300);
                imageProvider.cropImage(cropRect, context);
              },
            ),
            IconButton(
              icon: Icon(Icons.rotate_right),
              onPressed: () {
                imageProvider.rotateImage(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
