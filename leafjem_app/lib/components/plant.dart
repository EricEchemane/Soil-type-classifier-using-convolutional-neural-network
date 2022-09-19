import 'package:flutter/material.dart';

class Plant extends StatelessWidget {
  final String name;
  final String image;
  final String description;
  const Plant({
    Key? key,
    required this.name,
    required this.image,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 4,
              blurRadius: 7,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                child: ClipRRect(
                  child: Image(image: NetworkImage(image)),
                  borderRadius: BorderRadius.circular(6),
                ),
                width: deviceWidth),
            const SizedBox(height: 20),
            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(height: 1.5, fontSize: 15),
            )
          ],
        ));
  }
}
