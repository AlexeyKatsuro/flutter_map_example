import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map_example/domain/redux/app/app_middleware.dart';
import 'package:flutter_map_example/domain/redux/app/app_reducer.dart';
import 'package:flutter_map_example/domain/redux/app/app_state.dart';
import 'package:flutter_map_example/domain/repositories/place_search_repository.dart';
import 'package:flutter_map_example/domain/repositories/preferences_repository.dart';
import 'package:flutter_map_example/domain/services/place_search_service.dart';
import 'package:flutter_map_example/utils/json_serializable_converter.dart';
import 'package:get_it/get_it.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {
  serviceLocator.registerSingleton<GlobalKey<ScaffoldMessengerState>>(
    GlobalKey<ScaffoldMessengerState>(),
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerSingleton<SharedPreferences>(sharedPreferences);
  serviceLocator.registerLazySingleton<ChopperClient>(() {
    return ChopperClient(
        baseUrl: "https://nominatim.openstreetmap.org",
        converter: JsonSerializableConverter(),
        errorConverter: JsonSerializableConverter(),
        services: [PlaceSearchService.create()],
        interceptors: [HttpLoggingInterceptor()]);
  });

  serviceLocator.registerLazySingleton<PlaceSearchService>(() {
    return serviceLocator.get<ChopperClient>().getService<PlaceSearchService>();
  });

  serviceLocator.registerLazySingleton<PlaceSearchRepository>(() {
    return PlaceSearchRepository(searchService: serviceLocator.get());
  });
  serviceLocator.registerLazySingleton<PreferencesRepository>(() {
    return PreferencesRepository(preferences: serviceLocator.get());
  });

  serviceLocator.registerLazySingleton<Store<AppState>>(() {
    return Store<AppState>(
      appReducer,
      middleware: [
        LoggingMiddleware.printer(),
        ...createAppMiddleware(
            searchRepository: serviceLocator.get(),
            preferencesRepository: serviceLocator.get(),
            messengerKey: serviceLocator.get<GlobalKey<ScaffoldMessengerState>>()),
      ],
      initialState: AppState.initial(),
    );
  });
}
