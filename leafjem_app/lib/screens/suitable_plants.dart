import 'package:flutter/material.dart';

class SuitablePlantsScreen extends StatelessWidget {
  final String soilType;

  const SuitablePlantsScreen({Key? key, required this.soilType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Suitable plants for $soilType',
            )),
        body: Center(
          child: Text('Suitable plants for $soilType'),
        ));
  }
}
