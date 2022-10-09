import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leafjem_app/widgets/not_recognized.dart';
import 'package:leafjem_app/widgets/hyper_link.dart';
import 'package:leafjem_app/widgets/output_table.dart';
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
  bool notRecognized = false;

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
    );
    String label = output?[0]["label"];
    // double confidence = output?[0]["confidence"];

    if (label == "not" || label == "alike") {
      setState(() {
        notRecognized = true;
        _output = null;
      });
      return;
    }
    setState(() {
      _output = output?[0];
      notRecognized = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/final_model.tflite",
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
              'Pixsoil 🌱',
              style: TextStyle(fontFamily: 'Oleo', fontSize: 25),
            )),
        body: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              _selectedImage != null
                  ? Container(
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 4,
                            blurRadius: 7,
                          ),
                        ],
                      ),
                      child: SizedBox(
                        height: deviceWidth,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                              image: FileImage(File(_selectedImage!.path)),
                              width: deviceWidth,
                              fit: BoxFit.fill),
                        ),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 4,
                            blurRadius: 7,
                          ),
                        ],
                      ),
                      child: SizedBox(
                        height: deviceWidth,
                        child: const Center(
                            child: Text(
                          'No image is selected.\nSelect using one of the buttons below.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 1.5,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        )),
                      ),
                    ),
              _output != null && notRecognized == false
                  ? OutputTable(output: _output)
                  : Container(),
              notRecognized == true ? const NotRecognized() : Container(),
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
                    onPressed: _selectedImage != null ? clearImage : null,
                    child: const Text('Reset')),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const HyperLink(
                          displayText: 'What is Pixsoil?', path: '/about'),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const HyperLink(
                          displayText: 'The Researchers', path: '/researchers'),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const HyperLink(
                          displayText: 'Pixsoil for web', path: '/'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
