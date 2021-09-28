import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter_map_example/data/dto/error_response.dart';
import 'package:flutter_map_example/main.dart';

import 'mapper.dart';

extension ResponseHandleExt<F> on Future<Response<F>> {
  Future<T> handle<T>({Mapper<F, T>? mapper}) async {
    mapper ??= (from) {
      assert(from is T, {
        '$from is not $T. If you expect some data from request you must provide `mapper` argument',
      });
      return from as T;
    };

    try {
      final response = await this;
      if (response.isSuccessful) {
        return mapper(response.body!);
      } else {
        final error = ErrorResponse.fromJson(response.error as Map<String, dynamic>);
        return Future.error(error.error.message);
      }
    } on IOException catch (ex, stackTrace) {
      logger.warning(ex.toString(), ex, stackTrace);
      return Future.error('Network error');
    } catch (ex, stackTrace) {
      logger.warning(ex.toString(), ex, stackTrace);
      return Future.error('Unexpected error');
    }
  }
}
