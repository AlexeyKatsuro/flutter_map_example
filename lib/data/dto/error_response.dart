import 'package:flutter_map_example/data/model/place_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'error_response.g.dart';

@JsonSerializable()
class ErrorResponse {
  @JsonKey(name: "error")
  final ErrorDto error;

  const ErrorResponse({
    required this.error,
  });

  static const fromJson = _$ErrorResponseFromJson;

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);

}


@JsonSerializable()
class ErrorDto {
  @JsonKey(name: "code")
  final int code;
  @JsonKey(name: "message")
  final String message;

  ErrorDto(this.code, this.message);

  static const fromJson = _$ErrorDtoFromJson;

  Map<String, dynamic> toJson() => _$ErrorDtoToJson(this);
}
