import "dart:async";

import 'package:chopper/chopper.dart';
import 'package:flutter_map_example/data/dto/search_response.dart';

part 'place_search_service.chopper.dart';

@ChopperApi()
abstract class PlaceSearchService extends ChopperService {
  static PlaceSearchService create([ChopperClient? client]) => _$PlaceSearchService(client);

  @Get(path: '/search')
  Future<Response<List<PlaceResponse>>> searchPlace({
    @Query('q') required String query,
    @Query('format') String format = 'json',
  });
}
