// import 'dart:async';
import 'dart:io';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  // bool _loading = false;

  dynamic _output;

  @override
  void initState() {
    super.initState();

    loadModel().then((value) {
      setState(() {
        // _loading = false;
      });
    });
  }

  classifyImage() async {
    var output = await Tflite.runModelOnImage(
        path: _selectedImage!.path,
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );
    print(output);
    setState(() {
      // _loading = false;
      _output = output?[0];
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/soil_classifier.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  selectImageFromCamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _selectedImage = photo;
    });
    classifyImage();
  }

  selectImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = image;
    });
    classifyImage();
  }

  clearImage() {
    setState(() {
      _selectedImage = null;
      _output = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LeafJem')),
      body: Center(
        child: Column(
          children: [
            _selectedImage != null
                ? Image(
                    image: ResizeImage(FileImage(File(_selectedImage!.path)),
                        width: 255, height: 255, allowUpscaling: true),
                    fit: BoxFit.fitWidth,
                    alignment: FractionalOffset.center,
                  )
                // ? Image.file(File(_selectedImage!.path))
                : const Center(
                    child: Text('No image is selected'),
                    heightFactor: 30,
                  ),
            ElevatedButton(
                onPressed: selectImageFromCamera,
                child: const Text('Launch Camera')),
            ElevatedButton(
                onPressed: selectImageFromGallery,
                child: const Text('Select from gallery')),
            ElevatedButton(
                onPressed: clearImage, child: const Text('Clear image')),
            _output != null
                ? Column(
                    children: [
                      Text('Type: ' + _output['label']),
                      Text('Confidence: ' +
                          _output['confidence'].toStringAsFixed(3)),
                    ],
                  )
                : const Text('No results yet')
          ],
        ),
      ),
    );
  }
}
