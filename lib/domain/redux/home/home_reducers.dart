import 'package:collection/collection.dart';
import 'package:redux/redux.dart';

import 'home_actions.dart';
import 'home_state.dart';

Reducer<HomeState> homeReducer = combineReducers([
  TypedReducer<HomeState, SearchLoadingAction>(_searchLoadingReducer),
  TypedReducer<HomeState, SearchResponseAction>(_searchResponseReducer),
  TypedReducer<HomeState, ClearSelectedPlaceAction>(_clearSelectedPlaceReducer),
]);

HomeState _searchLoadingReducer(HomeState state, SearchLoadingAction action) {
  return state.copyIsLoading(isLoading: action.isLoading);
}

HomeState _searchResponseReducer(HomeState state, SearchResponseAction action) {
  return state.copySearchedPlaces(searchedPlaces: action.places);
}
HomeState _clearSelectedPlaceReducer(HomeState state, ClearSelectedPlaceAction action) {
  return state.copySearchedPlaces(searchedPlaces: null);
}
