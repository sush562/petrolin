import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

String createBackupJson(Map<String, dynamic> data) {
  return jsonEncode(data);
}

Future<bool> backupData(Map<String, dynamic> data) async {
  try {
    // Convert data to JSON
    final jsonString = createBackupJson(data);

    // Let user choose save location
    String? outputPath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save Backup File',
      fileName: 'my_app_backup.json',
    );

    if (outputPath == null) {
      print("User cancelled");
      return false;
    }

    // Write file
    final file = File(outputPath);
    await file.writeAsString(jsonString);

    print("Backup saved at: $outputPath");
    return true;
  } catch (e) {
    print("Backup failed: $e");
    return false;
  }
}

Future<Map<String, dynamic>?> restoreData() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Select Backup File',
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result == null) {
      print("User cancelled");
      return null;
    }

    final file = File(result.files.single.path!);

    final content = await file.readAsString();

    final data = jsonDecode(content);

    print("Data restored: $data");

    return data;
  } catch (e) {
    print("Restore failed: $e");
    return null;
  }
}
