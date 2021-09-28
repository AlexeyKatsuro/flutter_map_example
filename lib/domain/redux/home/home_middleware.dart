import 'package:flutter_map_example/domain/redux/app/app_actions.dart';
import 'package:flutter_map_example/domain/redux/app/app_middleware.dart';
import 'package:flutter_map_example/domain/redux/app/app_state.dart';
import 'package:flutter_map_example/domain/redux/home/home_actions.dart';
import 'package:flutter_map_example/domain/repositories/place_search_repository.dart';
import 'package:flutter_map_example/domain/repositories/preferences_repository.dart';
import 'package:flutter_map_example/main.dart';
import 'package:redux/redux.dart';

MiddlewareTyped<AppState, SearchRequestAction> createPlaceSearchMiddleware(
  PlaceSearchRepository searchRepository,
) {
  return (Store<AppState> store, SearchRequestAction requestAction, NextDispatcher next) async {
    next(const SearchLoadingAction(isLoading: true));
    try {
      final places = await searchRepository.searchPlace(requestAction.query);
      store.dispatch(SearchResponseAction(query: requestAction.query, places: places));
      if (places.isEmpty) {
        store.dispatch(ShowMessageAction(message: 'Not found'));
      }
    } catch (ex, stackTrace) {
      logger.warning(ex.toString(), ex, stackTrace);
      store.dispatch(ShowMessageAction(
        message: ex.toString(),
        subAction: MessageSubAction(label: 'Retry', action: requestAction),
      ));
    } finally {
      next(const SearchLoadingAction(isLoading: false));
    }
  };
}

MiddlewareTyped<AppState, SearchResponseAction> createSavePlaceSearchQueryMiddleware(
  PreferencesRepository preferencesRepository,
) {
  return (Store<AppState> store, SearchResponseAction action, NextDispatcher next) async {
    if (action.places.isNotEmpty) {
      preferencesRepository.lastPlaceSearchQuery = action.query;
    }
    next(action);
  };
}

MiddlewareTyped<AppState, ClearSelectedPlaceAction> createRemovePlaceSearchQueryMiddleware(
    PreferencesRepository preferencesRepository) {
  return (Store<AppState> store, ClearSelectedPlaceAction action, NextDispatcher next) async {
    preferencesRepository.lastPlaceSearchQuery = null;
    next(action);
  };
}
