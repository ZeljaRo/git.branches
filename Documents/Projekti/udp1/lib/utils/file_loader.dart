import 'package:flutter/services.dart' show rootBundle;

class FileLoader {
  static Future<String> loadSongText(String filename) async {
    try {
      final content = await rootBundle.loadString('assets/pjesme/$filename');
      return content;
    } catch (e) {
      return 'Greška: Ne mogu učitati $filename';
    }
  }
}
