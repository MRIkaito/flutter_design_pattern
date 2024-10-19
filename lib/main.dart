import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print("MyHomePageStateをビルド");
    // ChangeNotifierProviderにはcreateプロパティが必須
    return ChangeNotifierProvider(
      create: (context) => MyHomePageState(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Flutterラボ"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              WidgetA(),
              WidgetB(),
              WidgetC(),
            ],
          ),
        ),
      ),
    );
  }
}

// State(状態)とメソッド(ロジック)を管理する
class MyHomePageState extends ChangeNotifier {
  int counter = 0;
  void increment() {
    counter++;
    notifyListeners(); //StatefulWidgetのsetStateに近い→状態が変わったことを通知して再描画を行う
  }
}

class WidgetA extends StatelessWidget {
  const WidgetA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("WidgetAをビルド");
    return const Text(
      'You have pushed the button this many times:',
    );
  }
}

class WidgetB extends StatelessWidget {
  const WidgetB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("WidgetBをビルド");
    // context.watch<管理したい状態があるクラス>管理したい状態
    // watch・・・状態が変化していても，いなくても，ステートに含まれている情報が更新される(通知が来る)度に，常に再描画する
    //final int counter = context.watch<MyHomePageState>().counter;

    // context.select<管理したい状態があるクラス, 管理したい状態の型・クラス>((state) => state.管理したい状態名);
    // select・・・管理したい状態が変化したときのみ，再描画する
    final int counter =
        context.select<MyHomePageState, int>((state) => state.counter);
    return Text(
      '${counter}',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class WidgetC extends StatelessWidget {
  const WidgetC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // context.read<管理したい状態があるクラス>().メソッド;
    // read・・・いかなる時も，リビルド情報の再描画を行わない→見た目が全く変わらないものは，readとする方が良い．
    final Function increment = context.read<MyHomePageState>().increment;
    return ElevatedButton(
        onPressed: () {
          increment();
        },
        child: const Text('カウント'));
  }
}
