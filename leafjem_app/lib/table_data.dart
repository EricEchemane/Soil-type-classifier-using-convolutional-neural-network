import 'package:flutter/material.dart';

class TableData extends StatefulWidget {
  final String text;

  const TableData({Key? key, required this.text}) : super(key: key);

  @override
  State<TableData> createState() => _TableDataState();
}

class _TableDataState extends State<TableData> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(widget.text),
    );
  }
}
