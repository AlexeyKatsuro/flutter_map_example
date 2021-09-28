import 'package:flutter/cupertino.dart';
import 'package:flutter_map_example/data/model/place_model.dart';

@immutable
class HomeState {
  final List<PlaceModel>? searchedPlaces;
  final bool isLoading;

  const HomeState({
    required this.searchedPlaces,
    required this.isLoading,
  });

  factory HomeState.initial({List<PlaceModel>? searchedPlaces, bool? isLoading}) {
    return HomeState(
      searchedPlaces: searchedPlaces,
      isLoading: isLoading ?? false,
    );
  }

  HomeState copyIsLoading({required bool isLoading}) {
    return HomeState(searchedPlaces: searchedPlaces, isLoading: isLoading);
  }

  HomeState copySearchedPlaces({required List<PlaceModel>? searchedPlaces}) {
    return HomeState(searchedPlaces: searchedPlaces, isLoading: isLoading);
  }
}
