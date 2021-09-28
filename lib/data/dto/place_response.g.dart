// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceResponse _$PlaceResponseFromJson(Map<String, dynamic> json) {
  return PlaceResponse(
    placeId: (json['place_id'] as num?)?.toDouble(),
    licence: json['licence'] as String?,
    osmType: json['osm_type'] as String?,
    osmId: (json['osm_id'] as num?)?.toDouble(),
    boundingbox: (json['boundingbox'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    lat: json['lat'] as String?,
    lon: json['lon'] as String?,
    displayName: json['display_name'] as String?,
    xClass: json['class'] as String?,
    type: json['type'] as String?,
    importance: (json['importance'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$PlaceResponseToJson(PlaceResponse instance) =>
    <String, dynamic>{
      'place_id': instance.placeId,
      'licence': instance.licence,
      'osm_type': instance.osmType,
      'osm_id': instance.osmId,
      'boundingbox': instance.boundingbox,
      'lat': instance.lat,
      'lon': instance.lon,
      'display_name': instance.displayName,
      'class': instance.xClass,
      'type': instance.type,
      'importance': instance.importance,
    };
