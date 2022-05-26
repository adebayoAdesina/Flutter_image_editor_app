import 'package:flutter/material.dart';
import 'package:flutter_image_editor_app/Models/text_info.dart';

class ImageText extends StatelessWidget {
  final TextInfo textInfo;
  const ImageText({Key? key, required this.textInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      textInfo.text,
      textAlign: textInfo.textAlign,
      style: TextStyle(
          fontSize: textInfo.fontSize,
          fontWeight: textInfo.fontweight,
          fontStyle: textInfo.fontStyle,
          color: textInfo.color),
    );
  }
}
