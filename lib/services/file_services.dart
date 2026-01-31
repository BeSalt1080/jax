import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<File?> getSingleFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if (result != null && result.files.isNotEmpty) {
    return File(result.files.single.path!);
  }
  return null;
}

Future<List<File>?> getMultipleFiles() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if (result != null && result.files.isNotEmpty) {
    return result.files.map((f) => File(f.path!)).toList();
  }
  return null;
}
