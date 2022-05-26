import 'package:flutter/material.dart';
import 'package:flutter_image_editor_app/Views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Editor',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}
