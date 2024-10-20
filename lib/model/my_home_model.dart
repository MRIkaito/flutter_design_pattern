// import 'package:freezed_annotation/freezed_annotation.dart';
// part 'my_home_model.freezed.dart';

class MyHomePageModel {
  const MyHomePageModel({this.counter = 0});
  final int counter;

  MyHomePageModel copyWith(int counter) {
    return MyHomePageModel(counter: counter);
  }

  // counterに1を加算してカウンタを更新する
  MyHomePageModel updateCounter(int counter) {
    return copyWith(counter + 1);
  }
}
