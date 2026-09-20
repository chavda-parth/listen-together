import 'package:flutter/material.dart';
import 'package:listen_together/file_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CustomFilePicker filePicker = CustomFilePicker();

  String fileName = '';

  void setFileName(String result) {
    setState(() {
      fileName = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
          children: [
            FilledButton(
              onPressed: () async {
                String? result = await filePicker.pickFile();

                if (result != null)
                {
                  setFileName(result);
                }
              },
              child: Text("Select File"),
            ),
            Text("Filename: $fileName"),
          ],
        ),
    );
  }
}
