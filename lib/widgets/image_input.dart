import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  const ImageInput(this.onSelectImage, {super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  final msg = "Take picture";
  Future<void> _takePicture() async {
    final picker = ImagePicker();

    final imageFile =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage =
        await File(imageFile.path).copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        alignment: Alignment.center,
        width: 100,
        height: 100,
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
        child: _storedImage != null
            ? Image.file(
                _storedImage!,
                fit: BoxFit.cover,
                width: double.infinity,
              )
            : Text(
                msg,
                textAlign: TextAlign.center,
              ),
      ),
      const SizedBox(
        height: 10,
      ),
      Expanded(
          child: TextButton.icon(
              style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: _takePicture,
              icon: const Icon(Icons.camera),
              label: const Text('Take picture'))),
    ]);
  }
}
