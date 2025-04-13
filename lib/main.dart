import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expenz App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Inter"),
      home: Scaffold(
        body: Center(
          child: Text(
            "Expenz App",
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
