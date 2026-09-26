import 'package:flutter/services.dart';
import 'package:listen_together/constants.dart';

class CustomFilePicker {
  CustomFilePicker();

  final _channel = MethodChannel(filePickerChannelName);

  Future<String?> pickFile() async {
    try {
      final String? result = await _channel.invokeMethod<String>('pickFile');
      return result;
    } on PlatformException {
      return null;
    }
  }
}
