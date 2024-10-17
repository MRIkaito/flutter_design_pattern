import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void reBuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("MyHomePageStateをビルド");
    return MyHomePageInheritedWidget(
      data: this,
      counter: counter,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
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

class MyHomePageInheritedWidget extends InheritedWidget {
  const MyHomePageInheritedWidget({
    Key? key,
    required Widget child,
    required this.data,
    required this.counter,
  }) : super(key: key, child: child);

  final MyHomePageState data;
  final int counter;

  // 下記，決まり文句として記載するもの(として今は覚えておく)
  static MyHomePageState of(BuildContext context, {bool listen = true}) {
    if (listen) {
      // listen:trueだと，リビルド処理を行う(という旨の処理内容が記述されている)
      return (context
              .dependOnInheritedWidgetOfExactType<MyHomePageInheritedWidget>())!
          .data;
      // listen:flaseだと，リビルド処理を行わない(という旨の処理内容が記述されている)
    } else {
      return (context
              .getElementForInheritedWidgetOfExactType<
                  MyHomePageInheritedWidget>()!
              .widget as MyHomePageInheritedWidget)
          .data;
    }
  }

  // リビルドする条件をupdateShouldNotifyに記載することが可能
  // 本例では，counterの値が，更新前と異なる値であれば更新する，という風にしている
  @override
  bool updateShouldNotify(MyHomePageInheritedWidget oldWidget) {
    return counter != oldWidget.counter; // 値が変更されたときのみ，リビルドする
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
    final MyHomePageState state =
        MyHomePageInheritedWidget.of(context, listen: true);
    return Text(
      '${state.counter}',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class WidgetC extends StatelessWidget {
  const WidgetC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("WidgetCをビルド");
    final MyHomePageState state =
        MyHomePageInheritedWidget.of(context, listen: false);
    return ElevatedButton(
        onPressed: () {
          state.reBuild();
        },
        child: const Text('カウント'));
  }
}
