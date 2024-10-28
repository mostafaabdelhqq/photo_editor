import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class ImageProviderModel extends ChangeNotifier {
  File? _imageFile;
  img.Image? _originalImage;
  img.Image? _editedImage;
  double _filterStrength = 10.0;
  String _selectedFilter = 'None';

  File? get imageFile => _imageFile;
  double get filterStrength => _filterStrength;
  String get selectedFilter => _selectedFilter;

  // تحميل الصورة
  void loadImage(File file) {
    _imageFile = file;
    _originalImage = img.decodeImage(file.readAsBytesSync());
    _editedImage = _originalImage;
    _filterStrength = 1;
    _selectedFilter = 'None';
    notifyListeners();
  }

  void selectFilter(String filter) {
    _selectedFilter = filter;
    applyFilter();
    notifyListeners();
  }

  // ضبط شدة الفلتر
  void setFilterStrength(double strength) {
    _filterStrength = strength;
    applyFilter();
    notifyListeners();
  }

  // تطبيق الفلاتر
  Future<void> applyFilter() async {
    if (_originalImage == null) return;

    img.Image imageToFilter = _editedImage ?? _originalImage!;

    switch (_selectedFilter) {
      case 'Sobel':
        _editedImage =
            img.sobel(imageToFilter, amount: _filterStrength.toInt());
        break;
      case 'Laplacian':
        _editedImage = img.convolution(
          imageToFilter,
          [0, 1, 0, 1, -4, 1, 0, 1, 0],
        );
        break;
      case 'Gaussian':
        _editedImage = img.gaussianBlur(imageToFilter, _filterStrength.toInt());
        break;
      case 'Neighbourhood Average':
        _editedImage = img.grayscale(imageToFilter); // فلتر مؤقت
        break;
      default:
        _editedImage = _originalImage;
        break;
    }

    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/rotated_image.jpg';

    Uint8List encodedJpg = Uint8List.fromList(img.encodeJpg(_editedImage!));

    _imageFile = File(path)..writeAsBytesSync(encodedJpg);

    notifyListeners();
  }

  // دالة لتدوير الصورة بزاوية 90 درجة
  Future<void> rotateImage(BuildContext context) async {
    if (_originalImage != null) {
      _editedImage = img.copyRotate(_originalImage!, 45);
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/rotated_image.jpg';

      Uint8List encodedJpg = Uint8List.fromList(img.encodeJpg(_editedImage!));

      _imageFile = File(path)..writeAsBytesSync(encodedJpg);

      notifyListeners();

      // عرض SnackBar لتأكيد النجاح
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Image rotated successfully by 90 degrees!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image available for rotation!')),
      );
    }
  }

  // دالة لقص الصورة
  Future<void> cropImage(Rect cropRect, BuildContext context) async {
    if (_originalImage != null) {
      _editedImage = img.copyCrop(
        _originalImage!,
        cropRect.left.toInt(),
        cropRect.top.toInt(),
        cropRect.width.toInt(),
        cropRect.height.toInt(),
      );
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/rotated_image.jpg';

      Uint8List encodedJpg = Uint8List.fromList(img.encodeJpg(_editedImage!));

      _imageFile = File(path)..writeAsBytesSync(encodedJpg);

      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image cropped successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No image available for cropping!')));
    }
  }

  Future<File> saveEditedImage() async {
    if (_editedImage != null) {
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/filtered_image.jpg';
      Uint8List encodedImage = Uint8List.fromList(img.encodeJpg(_editedImage!));
      final file = File(path);
      file.writeAsBytesSync(encodedImage);
      return file;
    }
    throw Exception("No image to save");
  }
}
