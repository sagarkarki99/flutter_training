import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelectionPage extends StatelessWidget {
  const ImageSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final ImagePicker _picker = ImagePicker();
            final image = await _picker.pickImage(source: ImageSource.gallery);
            if (image == null) {
              return;
            }
            print('Image name: ${image.name}');
          },
          child: const Text('Select Image'),
        ),
      ),
    );
  }
}
