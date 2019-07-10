import 'package:flutter/widgets.dart';

class FileReader {
  FileReader(this.context);

  final BuildContext context;

  Future<String> assetFileReader(String filePath) {
    return DefaultAssetBundle.of(context).loadString(filePath);
  }
}
