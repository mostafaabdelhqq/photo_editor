import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class ImageProviderModel extends ChangeNotifier {
  File? _imageFile;
  img.Image? _originalImage;
  img.Image? _editedImage;
  String _selectedFilter = 'None';

  File? get imageFile => _imageFile;
  String get selectedFilter => _selectedFilter;

  // تحميل الصورة
  // تحميل الصورة
  void loadImage(File file) {
    _imageFile = file;
    _originalImage = img.decodeImage(file.readAsBytesSync());
    _editedImage = _originalImage; // إعادة تعيين الصورة المعدلة
    _selectedFilter = 'None';
    notifyListeners();
  }

  void applyFilter() async {
    if (_originalImage == null) return;

    // إذا لم تكن هناك صورة معدلة، نبدأ بالصورة الأصلية
    if (_editedImage == null) {
      _editedImage = img.copyResize(_originalImage!);
    }

    // تطبيق الفلتر على الصورة المعدلة الحالية
    img.Image imageToFilter = _editedImage!;

    switch (_selectedFilter) {
      case 'Sobel':
        _editedImage = img.convolution(
          imageToFilter,
          [0, 1, 0, 1, -4, 1, 0, 1, 0],
        );
        break;
      case 'Laplacian':
        _editedImage = img.convolution(
          imageToFilter,
          [1, 1, 1, 1, -8, 1, 1, 1, 1],
        );
        break;
      case 'Smoothing':
        _editedImage = img.convolution(
          imageToFilter,
          [1 / 9, 1 / 9, 1 / 9, 1 / 9, 1 / 9, 1 / 9, 1 / 9, 1 / 9, 1 / 9],
        );
        break;
      default:
        break;
    }

    _updateImageFile();
    notifyListeners();
  }

  void selectFilter(String filter) {
    _selectedFilter = filter;
    applyFilter();
    notifyListeners();
  }

  // تحديث ملف الصورة المعدلة
  void _updateImageFile() async {
    if (_editedImage == null)
      return; // إذا لم تكن هناك صورة معدلة، لا نقوم بتحديث الملف

    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/edited_image.jpg';
    Uint8List encodedJpg = Uint8List.fromList(img.encodeJpg(_editedImage!));
    _imageFile = File(path)..writeAsBytesSync(encodedJpg);
  }

  // حفظ الصورة المعدلة
  // حفظ الصورة المعدلة
  // حفظ الصورة المعدلة
// حفظ الصورة المعدلة
  Future<void> saveEditedImage(BuildContext context) async {
    if (_editedImage != null) {
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/filtered_image.jpg';
      Uint8List encodedImage = Uint8List.fromList(img.encodeJpg(_editedImage!));
      final file = File(path);
      file.writeAsBytesSync(encodedImage);

      // بعد حفظ الصورة، نقوم بإرجاع الحالة
      resetState();

      // إظهار رسالة للمستخدم بعد الحفظ
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image saved successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image to save')),
      );
    }
  }

// دالة لإعادة تعيين الحالة بعد حفظ الصورة
  void resetState() {
    _imageFile = null;
    _selectedFilter = 'None'; // إعادة تعيين الفلتر
    notifyListeners();
  }
}
