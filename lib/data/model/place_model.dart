import 'package:latlong2/latlong.dart';

class PlaceModel {
  final double placeId;
  final List<LatLng> boundingBox;
  final LatLng point;
  final String displayName;

  PlaceModel({
    required this.placeId,
    required this.boundingBox,
    required this.point,
    required this.displayName,
  });
}
