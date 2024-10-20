import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design_pattern/main.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print("MyHomePageStateをビルド");
    // ChangeNotifierProviderにはcreateプロパティが必須
    return ProviderScope(
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

class WidgetB extends ConsumerWidget {
  const WidgetB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("WidgetB をビルド");
    // context.watch<管理したい状態があるクラス>管理したい状態
    // watch・・・状態が変化していても，いなくても，ステートに含まれている情報が更新される(通知が来る)度に，常に再描画する
    // StateNotifierを用いると，stateに変更があったときのみ再描画されるので，watchを用いても問題なし
    final int counter = ref.watch(myHomePageProvider).counter;

    return Text(
      '${counter}',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class WidgetC extends ConsumerWidget {
  const WidgetC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("WidgetCをビルド");
    // context.read<管理したい状態があるクラス>().メソッド;
    // read・・・いかなる時も，リビルド情報の再描画を行わない→見た目が全く変わらないものは，readとする方が良い．
    final Function increment = ref.read(myHomePageProvider.notifier).increment;
    return ElevatedButton(
        onPressed: () {
          increment();
        },
        child: const Text('カウント'));
  }
}
