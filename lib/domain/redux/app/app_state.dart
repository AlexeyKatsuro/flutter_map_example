import 'package:flutter_map_example/domain/redux/home/home_state.dart';

class AppState {
  final HomeState homeState;

  AppState({
    required this.homeState,
  });

  factory AppState.initial({HomeState? homeState}) {
    return AppState(homeState: homeState ?? HomeState.initial());
  }
}
