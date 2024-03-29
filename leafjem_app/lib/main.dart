import 'package:flutter/material.dart';
import 'package:leafjem_app/constants/pallete.dart';
import 'package:leafjem_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pixsoil',
      theme: ThemeData(
        primarySwatch: Pallete.mcgpalette0,
      ),
      home: const HomeScreen(),
    );
  }
}
