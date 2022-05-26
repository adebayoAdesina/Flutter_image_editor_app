import 'package:flutter/material.dart';
import 'package:flutter_image_editor_app/Views/edit_image.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
            onPressed: () async {
              XFile? file =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (file != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => EditImage(selectedImage: file.path)));
              } 
              else {
                const Center(child: Text('No image selected'));
              }
            },
            icon: Icon(Icons.upload_file)),
      ),
    );
  }
}
