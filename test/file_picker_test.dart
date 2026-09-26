import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listen_together/constants.dart';
import 'package:listen_together/file_picker.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final testChannel = MethodChannel(filePickerChannelName);
  test('File string matches.', () async {
    final testPicker = CustomFilePicker();

    const String testFile = '/storage/emulated/0/test.txt';

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.
      setMockMethodCallHandler(testChannel, (MethodCall call) async {
      return testFile;
    });
    
    expect(await testPicker.pickFile(), equals(testFile));
  });

  test('User cancels file picking.', () async {
    final testPicker = CustomFilePicker();

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.
      setMockMethodCallHandler(testChannel, (MethodCall call) async {
        return null;
      });
    
    expect(await testPicker.pickFile(), equals(null));
  });

  test('Platform exception thrown.', () async {
    final testPicker = CustomFilePicker();
    final exception = PlatformException(code: 'Test Exception Thrown');

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.
      setMockMethodCallHandler(testChannel, (MethodCall call) async {
        throw exception;
      });
    
    expect(await testPicker.pickFile(), equals(null));
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.
      setMockMethodCallHandler(testChannel, null);
  });
}