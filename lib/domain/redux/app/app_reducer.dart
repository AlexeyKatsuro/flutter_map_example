import 'package:flutter_map_example/domain/redux/home/home_reducers.dart';

import 'app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    homeState: homeReducer(state.homeState, action),
  );
}
