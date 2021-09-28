import 'package:flutter/material.dart';
import 'package:flutter_map_example/domain/redux/home/home_actions.dart';
import 'package:flutter_map_example/domain/redux/home/home_middleware.dart';
import 'package:flutter_map_example/domain/repositories/place_search_repository.dart';
import 'package:flutter_map_example/domain/repositories/preferences_repository.dart';
import 'package:redux/redux.dart';

import 'app_actions.dart';
import 'app_state.dart';

typedef MiddlewareTyped<State, Action> = dynamic Function(
  Store<State> store,
  Action action,
  NextDispatcher next,
);

List<Middleware<AppState>> createAppMiddleware({
  required PlaceSearchRepository searchRepository,
  required PreferencesRepository preferencesRepository,
  required GlobalKey<ScaffoldMessengerState> messengerKey,
}) {
  return [
    TypedMiddleware<AppState, InitialAction>(_createInitialMiddleware(preferencesRepository)),
    TypedMiddleware<AppState, SearchRequestAction>(createPlaceSearchMiddleware(searchRepository)),
    TypedMiddleware<AppState, SearchResponseAction>(
      createSavePlaceSearchQueryMiddleware(preferencesRepository),
    ),
    TypedMiddleware<AppState, ClearSelectedPlaceAction>(
      createRemovePlaceSearchQueryMiddleware(preferencesRepository),
    ),
    TypedMiddleware<AppState, ShowMessageAction>(createMessengerMiddleware(messengerKey)),
  ];
}

MiddlewareTyped<AppState, InitialAction> _createInitialMiddleware(
  PreferencesRepository preferencesRepository,
) {
  return (Store<AppState> store, InitialAction action, NextDispatcher next) {
    final lastPlaceSearchQuery = preferencesRepository.lastPlaceSearchQuery ?? '';
    if (lastPlaceSearchQuery.isNotEmpty) {
      next(SearchRequestAction(lastPlaceSearchQuery));
    }
    // Your can emit some other action on Initial event
  };
}

MiddlewareTyped<AppState, ShowMessageAction> createMessengerMiddleware(
    GlobalKey<ScaffoldMessengerState> messengerKey) {
  return (Store<AppState> store, ShowMessageAction action, NextDispatcher next) {
    final state = messengerKey.currentState;
    if (state != null) {
      final snackBarAction = action.subAction != null
          ? SnackBarAction(
              label: action.subAction!.label,
              onPressed: () => store.dispatch(action.subAction!.action),
            )
          : null;
      state.showSnackBar(SnackBar(content: Text(action.message), action: snackBarAction));
    }
    // Your can emit some other action on Initial event
  };
}
