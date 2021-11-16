import 'package:flutter/material.dart';
import 'screens/loading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wearther App',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: Loading(),
    );
  }
}
