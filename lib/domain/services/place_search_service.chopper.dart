// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_search_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$PlaceSearchService extends PlaceSearchService {
  _$PlaceSearchService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = PlaceSearchService;

  @override
  Future<Response<List<PlaceResponse>>> searchPlace(
      {required String query, String format = 'json'}) {
    final $url = '/search';
    final $params = <String, dynamic>{'q': query, 'format': format};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<PlaceResponse>, PlaceResponse>($request);
  }
}
