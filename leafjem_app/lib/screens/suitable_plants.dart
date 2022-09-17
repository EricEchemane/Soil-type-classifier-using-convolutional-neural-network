import 'package:flutter/material.dart';

enum SoilTypes {
  clay,
  gravel,
  humus,
  sand,
  silt,
}

class SuitablePlantsScreen extends StatelessWidget {
  final SoilTypes soilType;

  const SuitablePlantsScreen({Key? key, required this.soilType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
