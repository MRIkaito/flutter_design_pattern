import 'package:flutter/material.dart';
import 'package:design_pattern/view/my_home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design_pattern/model/my_home_model.dart';
import 'package:design_pattern/view_model/my_home_view_moder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
