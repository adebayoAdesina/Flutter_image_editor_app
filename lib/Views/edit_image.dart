import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_editor_app/Widgets/edit_image_viewmode.dart';
import 'package:screenshot/screenshot.dart';

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
      appBar: _appBar,
      body: Screenshot(
        controller: screenshotController,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [
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
                          removeText(context, i);
                        },
                        onTap: () => setCurrentIndex(context, i),
                      ),
                    ),
                  creatorText.text.isNotEmpty
                      ? Positioned(
                          left: 0,
                          bottom: 0,
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

  AppBar get _appBar => AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                IconButton(
                  onPressed: () => saveToGallery(context),
                  icon: const Icon(
                    Icons.save,
                    color: Colors.black,
                  ),
                  tooltip: 'Save Image',
                ),
                IconButton(
                  onPressed: () => increaseFontSize(),
                  icon: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  tooltip: 'Add font size',
                ),
                IconButton(
                  onPressed: () => decreaseFontSize(),
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.black,
                  ),
                  tooltip: 'Decrease font size',
                ),
                IconButton(
                  onPressed: () => alignFont('left'),
                  icon: const Icon(
                    Icons.format_align_left,
                    color: Colors.black,
                  ),
                  tooltip: 'Align Left',
                ),
                IconButton(
                  onPressed: () => alignFont('center'),
                  icon: const Icon(
                    Icons.format_align_center,
                    color: Colors.black,
                  ),
                  tooltip: 'Align Center',
                ),
                IconButton(
                  onPressed: () => alignFont('right'),
                  icon: const Icon(
                    Icons.format_align_right,
                    color: Colors.black,
                  ),
                  tooltip: 'Align Right',
                ),
                IconButton(
                  onPressed: boldFontSize,
                  icon: const Icon(
                    Icons.format_bold,
                    color: Colors.black,
                  ),
                  tooltip: 'Bold',
                ),
                IconButton(
                  onPressed: italicText,
                  icon: const Icon(
                    Icons.format_italic,
                    color: Colors.black,
                  ),
                  tooltip: 'Italic',
                ),
                IconButton(
                  onPressed: () => addLinesToText(),
                  icon: const Icon(
                    Icons.space_bar,
                    color: Colors.black,
                  ),
                  tooltip: 'Add New Line',
                ),
                Tooltip(
                  message: 'white',
                  child: GestureDetector(
                    onTap: () => changeTextColor(Colors.grey.withOpacity(0.2)),
                    child: CircleAvatar(
                        backgroundColor: Colors.grey.withOpacity(0.2)),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Tooltip(
                  message: 'green',
                  child: GestureDetector(
                    onTap: () => changeTextColor(Colors.green),
                    child: const CircleAvatar(backgroundColor: Colors.green),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Tooltip(
                  message: 'blue',
                  child: GestureDetector(
                    onTap: () => changeTextColor(Colors.blue),
                    child: const CircleAvatar(backgroundColor: Colors.blue),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Tooltip(
                  message: 'red',
                  child: GestureDetector(
                    onTap: () => changeTextColor(Colors.red),
                    child: const CircleAvatar(backgroundColor: Colors.red),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Tooltip(
                  message: 'black',
                  child: GestureDetector(
                    onTap: () => changeTextColor(Colors.black),
                    child: const CircleAvatar(backgroundColor: Colors.black),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Tooltip(
                  message: 'Orange',
                  child: GestureDetector(
                    onTap: () => changeTextColor(Colors.orange),
                    child: const CircleAvatar(backgroundColor: Colors.orange),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Tooltip(
                  message: 'pink',
                  child: GestureDetector(
                    onTap: () => changeTextColor(Colors.pink),
                    child: const CircleAvatar(backgroundColor: Colors.pink),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
            )),
      );
}
