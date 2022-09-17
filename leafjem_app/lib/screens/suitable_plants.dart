import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:leafjem_app/components/plant.dart';

class SuitablePlantsScreen extends StatefulWidget {
  final String soilType;
  final String overview;
  final List<Map<String, String>>? suitablePlants;

  const SuitablePlantsScreen(
      {Key? key,
      required this.soilType,
      required this.overview,
      required this.suitablePlants})
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
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 4,
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: Center(
                    child: Text(
                  '${widget.overview} are suitable for ${widget.soilType}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
              ),
              ListView.builder(
                itemBuilder: (_, index) {
                  String? name = widget.suitablePlants![index]["name"];
                  String? image = widget.suitablePlants![index]["image"];
                  String? description =
                      widget.suitablePlants![index]["description"];
                  return Plant(
                      name: name!, description: description!, image: image!);
                },
                itemCount: widget.suitablePlants?.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ])));
  }
}
