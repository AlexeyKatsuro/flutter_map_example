import 'package:collection/collection.dart';
import 'package:flutter_map_example/data/model/place_model.dart';
import 'package:flutter_map_example/domain/redux/app/app_state.dart';

bool isLoadingSelector(AppState state) => state.homeState.isLoading;

List<PlaceModel>? searchedPlaceSelector(AppState state) => state.homeState.searchedPlaces;

PlaceModel? selectedPlaceSelector(AppState state) => searchedPlaceSelector(state)?.firstOrNull;
