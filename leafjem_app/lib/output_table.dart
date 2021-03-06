import 'package:flutter/material.dart';
import 'package:leafjem_app/soil_props.dart';
import 'package:leafjem_app/table_data.dart';

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
                const TableData(text: 'Confidence'),
                TableData(text: '${widget.output["confidence"]}')
              ]),
              TableRow(children: [
                const TableData(text: 'Rounded Confidence'),
                TableData(
                    text: '${widget.output["confidence"].roundToDouble()}')
              ]),
              // TableRow(children: [
              //   const TableData(text: 'Colors'),
              //   TableData(text: '${props["colors"]}')
              // ]),
              TableRow(children: [
                const TableData(text: 'Grain Size'),
                TableData(text: '${props["grain_size"]}')
              ]),
              TableRow(children: [
                const TableData(text: 'Acidity'),
                TableData(text: '${props["acidity"]}')
              ]),
              TableRow(children: [
                const TableData(text: 'Texture'),
                TableData(text: '${props["texture"]}')
              ]),
              TableRow(children: [
                const TableData(text: 'How To Test'),
                TableData(text: '${props["how_to_test"]}')
              ]),
              TableRow(children: [
                const TableData(text: 'Water and Nutrient Holding Capacity'),
                TableData(
                    text: '${props["water_and_nutrient_holding_capacity"]}')
              ]),
              TableRow(children: [
                const TableData(text: 'Porosity'),
                TableData(text: '${props["porosity"]}')
              ]),
              TableRow(children: [
                const TableData(text: 'Other Properties'),
                TableData(text: '${props["other_properties"]}')
              ]),
              TableRow(children: [
                const TableData(text: 'how To Improve'),
                TableData(text: '${props["how_to_improve"]}')
              ]),
              TableRow(children: [
                const TableData(text: 'Suitable Plants'),
                TableData(text: '${props["suitable_plants"]}')
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
