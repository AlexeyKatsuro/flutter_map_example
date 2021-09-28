// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) {
  return ErrorResponse(
    error: ErrorDto.fromJson(json['error'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ErrorResponseToJson(ErrorResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
    };

ErrorDto _$ErrorDtoFromJson(Map<String, dynamic> json) {
  return ErrorDto(
    json['code'] as int,
    json['message'] as String,
  );
}

Map<String, dynamic> _$ErrorDtoToJson(ErrorDto instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };
