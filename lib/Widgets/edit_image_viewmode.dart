import 'package:flutter/material.dart';
import 'package:flutter_image_editor_app/Models/text_info.dart';
import 'package:flutter_image_editor_app/Views/edit_image.dart';
import 'package:flutter_image_editor_app/Widgets/default_button.dart';

abstract class EditImageViewModel extends State<EditImage> {
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController creatorText = TextEditingController();
  List<TextInfo> info = [];

  addNewText(BuildContext context) {
    setState(() {
      info.add(TextInfo(
          text: textEditingController.text,
          left: 0,
          top: 0,
          color: Colors.black,
          fontweight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          fontSize: 20,
          textAlign: TextAlign.left));
    });
    Navigator.of(context).pop();
  }

  addNewDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Add new Text'),
        content: TextField(
          controller: textEditingController,
          maxLines: 5,
          decoration: const InputDecoration(
              suffixIcon: Icon(Icons.edit),
              filled: true,
              hintText: 'Your Text here'),
        ),
        actions: [
          DefaultButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Back'),
              color: Colors.red,
              textColor: Colors.white),
          DefaultButton(
              onPressed: () => addNewText(context),
              child: const Text('Add Text'),
              color: Colors.green,
              textColor: Colors.white)
        ],
      ),
    );
  }
}
