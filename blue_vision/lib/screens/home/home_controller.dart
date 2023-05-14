import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_state.dart';

class HomeController extends StateNotifier<HomeScreenState> {
  HomeController(this._ref): super(const HomeScreenState());

  final Ref _ref;

  void doSomething() {
    // TODO: implement
  }
}
