import 'package:flutter_map_example/data/model/place_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'place_response.g.dart';

@JsonSerializable()
class PlaceResponse {
  @JsonKey(name: "place_id")
  final double? placeId;
  @JsonKey(name: "licence")
  final String? licence;
  @JsonKey(name: "osm_type")
  final String? osmType;
  @JsonKey(name: "osm_id")
  final double? osmId;
  @JsonKey(name: "boundingbox")
  final List<String>? boundingbox;
  @JsonKey(name: "lat")
  final String? lat;
  @JsonKey(name: "lon")
  final String? lon;
  @JsonKey(name: "display_name")
  final String? displayName;
  @JsonKey(name: "class")
  final String? xClass;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "importance")
  final double? importance;

  const PlaceResponse({
    required this.placeId,
    required this.licence,
    required this.osmType,
    required this.osmId,
    required this.boundingbox,
    required this.lat,
    required this.lon,
    required this.displayName,
    required this.xClass,
    required this.type,
    required this.importance,
  });

  static const fromJson = _$PlaceResponseFromJson;

  Map<String, dynamic> toJson() => _$PlaceResponseToJson(this);

  PlaceModel toModel() {
    assert(placeId != null, '`placeId` field must be not null');
    assert(boundingbox != null && boundingbox!.isNotEmpty,
        '`boundingbox` field must be not null and not empty');
    assert(displayName != null, '`displayName` field must be not null');
    assert(lat != null, '`lat` field must be not null');
    assert(lon != null, '`lon` field must be not null');

    List<LatLng> mapBoundingBox(List<String> box) {
      final p1 = double.parse(box[0]);
      final p2 = double.parse(box[1]);
      final p3 = double.parse(box[2]);
      final p4 = double.parse(box[3]);
      final corner1 = LatLng(p2, p3);
      final corner2 = LatLng(p1, p4);
      return [corner1, corner2];
    }

    final point = LatLng(double.parse(lat!), double.parse(lon!));
    return PlaceModel(
      placeId: placeId!,
      boundingBox: mapBoundingBox(boundingbox!),
      point: point,
      displayName: displayName!,
    );
  }
}
