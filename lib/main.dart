import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design_pattern/screen/my_home_page.dart';
import 'package:design_pattern/state/my_home_state.dart';
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

// reverpodのStateNotifierProviderを利用
final myHomePageProvider =
    StateNotifierProvider<MyHomePageStateNotifier, MyHomePageState>(
        (ref) => MyHomePageStateNotifier());
