import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design_pattern/state/my_home_state.dart';

class MyHomePageStateNotifier extends StateNotifier<MyHomePageState> {
  MyHomePageStateNotifier() : super(const MyHomePageState());

  void increment() {
    state = state.copyWith(state.counter + 1);
  }
}
