import 'package:flutter_map_example/data/dto/error_response.dart';
import 'package:flutter_map_example/data/dto/search_response.dart';
import 'package:flutter_map_example/utils/json_serializable_converter.dart';

const Map<Type, JsonFactory> jsonResponseFactories = {
  // Add all `fromJson` factories here for JsonSerializable classes
  PlaceResponse: PlaceResponse.fromJson,
  ErrorDto: ErrorDto.fromJson,
  ErrorResponse: ErrorResponse.fromJson,
};
