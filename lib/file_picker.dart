import 'package:flutter/services.dart';

class CustomFilePicker {
  CustomFilePicker();

  final MethodChannel channel = MethodChannel(
    'com.listen_together.app/customfilepicker',

  );

  Future<String?> pickFile() async {
    try {
      final String? result = await channel.invokeMethod<String>('pickFile');
      return result;
    } on PlatformException {
      return null;
    }
  }
}
