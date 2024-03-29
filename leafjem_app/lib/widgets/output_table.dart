import 'package:flutter/material.dart';
import 'package:leafjem_app/widgets/table_data.dart';
import 'package:leafjem_app/screens/suitable_plants.dart';
import 'package:leafjem_app/constants/soil_props.dart';
import 'package:leafjem_app/constants/plants.dart';

class OutputTable extends StatefulWidget {
  final dynamic output;

  const OutputTable({Key? key, required this.output}) : super(key: key);

  @override
  State<OutputTable> createState() => _OutputTableState();
}

class _OutputTableState extends State<OutputTable> {
  @override
  Widget build(BuildContext context) {
    dynamic props = soilProps
        .firstWhere((element) => element["name"] == widget.output["label"]);

    double deviceWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              const TableRow(children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Results',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Text('')
              ]),
              const TableRow(children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Label',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Values',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ),
              ]),
              TableRow(children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Soil Type'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    '${widget.output["label"]}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.blue),
                  ),
                ),
              ]),
              TableRow(children: [
                const TableData(text: 'Accuracy'),
                TableData(text: '${widget.output["confidence"]}')
              ]),
              TableRow(children: [
                const TableData(text: 'Overview'),
                TableData(text: '${props["Overview"]}')
              ]),
              TableRow(children: [
                const TableData(text: 'Grain Size'),
                TableData(text: '${props["Grain Size"]}')
              ]),
              TableRow(children: [
                const TableData(text: 'Acidity'),
                TableData(text: '${props["Acidity"]}')
              ]),
              TableRow(children: [
                const TableData(text: 'Texture'),
                TableData(text: '${props["Texture"]}')
              ]),
              TableRow(children: [
                const TableData(text: 'How to verify the type'),
                TableData(text: '${props["How to verify the type"]}')
              ]),
              TableRow(children: [
                const TableData(text: 'Water and Nutrient Holding Capacity'),
                TableData(
                    text: '${props["Water and Nutrient Holding Capacity"]}')
              ]),
              TableRow(children: [
                const TableData(text: 'Porosity'),
                TableData(text: '${props["Porosity"]}')
              ]),
              TableRow(children: [
                const TableData(text: 'Other Properties'),
                TableData(text: '${props["Other properties"]}')
              ]),
              TableRow(children: [
                const TableData(text: 'how To Improve'),
                TableData(text: '${props["How to improve the soil"]}')
              ]),
            ],
          ),
          Container(
            width: deviceWidth,
            height: 70,
            padding: const EdgeInsets.all(10),
            child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SuitablePlantsScreen(
                        soilType: widget.output["label"],
                        overview: props["Suitable Plants"],
                        suitablePlants: plants[props["Suitable Plants"]],
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.open_in_new_outlined),
                label: Text(
                    'See list of suitable plants for ${widget.output["label"]}')),
          ),
        ],
      ),
    );
  }
}
