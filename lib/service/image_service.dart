import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PickImage {
  late ImagePicker? _imagePciker;

  PickImage.init() {
    _imagePciker = ImagePicker();
  }

  static final instance = PickImage.init();

  factory PickImage() => instance;

  Future<File?> pickImageFromStorage(ImageSource? source) async {
    File? file;
    try {
      final imageFile = await _imagePciker!.pickImage(source: source!);
      if (imageFile != null) {
        var file = File(imageFile.path);
        return file;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  ImagePicker? get imagePicker => _imagePciker;
}
