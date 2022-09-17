import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SuitablePlantsScreen extends StatefulWidget {
  final String soilType;
  final String overview;

  const SuitablePlantsScreen(
      {Key? key, required this.soilType, required this.overview})
      : super(key: key);

  @override
  State<SuitablePlantsScreen> createState() => _SuitablePlantsScreenState();
}

class _SuitablePlantsScreenState extends State<SuitablePlantsScreen> {
  final ScrollController scrollController = ScrollController();

  bool networkConnected = false;

  @override
  void initState() {
    InternetConnectionChecker().hasConnection.then((value) => {
          setState(() {
            networkConnected = value;
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Suitable plants for ${widget.soilType}',
            )),
        body: SingleChildScrollView(
          controller: scrollController,
          child: Column(children: [
            Text(widget.overview),
            Text(networkConnected ? 'connected' : 'not connected'),
          ]),
        ));
  }
}
