import 'package:flutter_map_example/data/model/place_model.dart';

class SearchRequestAction {
  final String query;

  SearchRequestAction(this.query);
}

class SearchLoadingAction {
  final bool isLoading;

  const SearchLoadingAction({required this.isLoading});
}

class SearchResponseAction {
  final List<PlaceModel> places;
  final String query;

  SearchResponseAction({required this.query, required this.places});
}

class ClearSelectedPlaceAction {
  const ClearSelectedPlaceAction();
}
