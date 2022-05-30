import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_editor_app/Models/text_info.dart';
import 'package:flutter_image_editor_app/Views/edit_image.dart';
import 'package:flutter_image_editor_app/Widgets/default_button.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../utils/util.dart';

abstract class EditImageViewModel extends State<EditImage> {
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController creatorText = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();
  List<TextInfo> info = [];
  int currentIndex = 0;

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

  setCurrentIndex(BuildContext context, int i) {
    setState(() {
      currentIndex = i;
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
      'Selected for styling',
      style: TextStyle(fontSize: 16.0),
    )));
  }

  changeTextColor(Color colors) {
    setState(() {
      info[currentIndex].color = colors;
    });
  }

  increaseFontSize() {
    setState(() {
      info[currentIndex].fontSize += 2;
    });
  }

  decreaseFontSize() {
    setState(() {
      info[currentIndex].fontSize -= 2;
    });
  }

  addLinesToText() {
    setState(() {
      if (info[currentIndex].text.contains('\n')) {
        info[currentIndex].text = info[currentIndex].text.replaceAll('\n', '');
      } else {
        info[currentIndex].text = info[currentIndex].text.replaceAll(' ', '\n');
      }
    });
  }

  FontWeight? fontWeight;

  boldFontSize() {
    if (fontWeight == FontWeight.bold) {
      setState(() {
        info[currentIndex].fontweight = FontWeight.normal;
        fontWeight = FontWeight.normal;
      });
    } else {
      setState(() {
        info[currentIndex].fontweight = FontWeight.bold;
        fontWeight = FontWeight.bold;
      });
    }
  }

  FontStyle fontStyle = FontStyle.italic;

  italicText() {
    if (fontStyle == FontStyle.italic) {
      setState(() {
        info[currentIndex].fontStyle = fontStyle;
        fontStyle = FontStyle.normal;
      });
    } else {
      setState(() {
        info[currentIndex].fontStyle = fontStyle;
        fontStyle = FontStyle.italic;
      });
    }
  }

  alignFont(String value) {
    switch (value) {
      case 'left':
        setState(() {
          info[currentIndex].textAlign = TextAlign.left;
        });
        break;
      case 'right':
        setState(() {
          info[currentIndex].textAlign = TextAlign.right;
        });
        break;
      case 'center':
        setState(() {
          info[currentIndex].textAlign = TextAlign.center;
        });
        break;
      default:
    }
  }

  removeText(BuildContext context, index) {
    setState(() {
      info.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
      'Deleted',
      style: TextStyle(fontSize: 16.0),
    )));
  }

  saveImage(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = "screenshot_$time";

    await requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(bytes, name: name);
  }

  saveToGallery(BuildContext context) {
    if (info.isNotEmpty) {
      screenshotController
          .capture()
          .then((Uint8List? image) => {
                saveImage(image!),
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Image saved to gallery')))
              })
          .catchError((error) => print(error.toString()));
    }
  }
}
