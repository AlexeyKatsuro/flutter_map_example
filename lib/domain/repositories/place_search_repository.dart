import 'package:flutter_map_example/data/dto/search_response.dart';
import 'package:flutter_map_example/data/model/place_model.dart';
import 'package:flutter_map_example/domain/services/place_search_service.dart';
import 'package:flutter_map_example/utils/mapper.dart';
import 'package:flutter_map_example/utils/response_handler.dart';

class PlaceSearchRepository {
  final PlaceSearchService _searchService;

  PlaceSearchRepository({required PlaceSearchService searchService})
      : _searchService = searchService;

  Future<List<PlaceModel>> searchPlace(String query) {
    return _searchService
        .searchPlace(query: query)
        .handle(mapper: toListMapper((place) => place.toModel()));
  }
}
