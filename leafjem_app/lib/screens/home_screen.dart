// import 'dart:async';
import 'dart:io';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leafjem_app/components/output_table.dart';
import 'package:tflite/tflite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  dynamic _output;

  @override
  void initState() {
    super.initState();

    loadModel().then((value) {});
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

  scrollToTop() {
    scrollController.animateTo(
        //go to top of scroll
        0, //scroll offset to go
        duration: const Duration(milliseconds: 500), //duration of scroll
        curve: Curves.fastOutSlowIn //scroll type
        );
  }

  clearImage() {
    setState(() {
      _selectedImage = null;
      _output = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Pixsoil',
              style: TextStyle(fontFamily: 'Oleo', fontSize: 25),
            )),
        body: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              _selectedImage != null
                  ? SizedBox(
                      height: deviceWidth,
                      child:
                          Image(image: FileImage(File(_selectedImage!.path))),
                    )
                  : SizedBox(
                      height: deviceWidth,
                      child: const Center(child: Text('No image is selected')),
                    ),
              _output != null ? OutputTable(output: _output) : Container(),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    width: deviceWidth / 2,
                    height: 70,
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () async {
                          final XFile? photo = await _picker.pickImage(
                              source: ImageSource.camera);
                          if (photo == null) return;
                          setState(() {
                            _selectedImage = photo;
                          });
                          classifyImage();
                          scrollToTop();
                        },
                        child: const Text('Take a picture')),
                  ),
                  Container(
                    width: deviceWidth / 2,
                    height: 70,
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () async {
                          final XFile? photo = await _picker.pickImage(
                              source: ImageSource.gallery);
                          if (photo == null) return;
                          setState(() {
                            _selectedImage = photo;
                          });
                          classifyImage();
                          scrollToTop();
                        },
                        child: const Text('Select from files')),
                  )
                ],
              ),
              Container(
                width: deviceWidth,
                height: 70,
                padding: const EdgeInsets.all(10),
                child: OutlinedButton(
                    onPressed: clearImage, child: const Text('Reset')),
              ),
            ],
          ),
        ));
  }
}
