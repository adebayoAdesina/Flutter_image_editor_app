import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_editor_app/Widgets/edit_image_viewmode.dart';

import '../Widgets/image_text.dart';

class EditImage extends StatefulWidget {
  final String selectedImage;
  const EditImage({Key? key, required this.selectedImage}) : super(key: key);

  @override
  State<EditImage> createState() => _EditImageState();
}

class _EditImageState extends EditImageViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Stack(children: [
              _selectedImage,
              for (var i = 0; i < info.length; i++)
                Positioned(
                  left: info[i].left,
                  top: info[i].top,
                  child: GestureDetector(
                    child: Draggable(
                      child: ImageText(textInfo: info[i]),
                      feedback: ImageText(textInfo: info[i]),
                      onDragEnd: (drag) {
                        final renderBox =
                            context.findRenderObject() as RenderBox;
                        Offset off = renderBox.globalToLocal(drag.offset);
                        setState(() {
                          info[i].top = off.dy - 96;
                          info[i].left = off.dx;
                        });
                      },
                    ),
                    onLongPress: () {
                      print('long press detected');
                    },
                    onTap: () {
                      print('single press detected');
                    },
                  ),
                ),
              creatorText.text.isNotEmpty
                  ? Positioned(
                      child: Text(
                      creatorText.text,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.3)),
                    ))
                  : const SizedBox.shrink()
            ])
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addNewDialog(context),
        backgroundColor: Colors.white,
        tooltip: 'Add New Text',
        child: const Icon(Icons.edit),
      ),
    );
  }

  Widget get _selectedImage => Center(
        child: Image.file(
          File(widget.selectedImage),
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      );
}
