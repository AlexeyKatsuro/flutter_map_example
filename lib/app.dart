import 'package:flutter/material.dart';
import 'package:flutter_map_example/domain/redux/app/app_actions.dart';
import 'package:flutter_map_example/domain/redux/app/app_state.dart';
import 'package:flutter_map_example/theme.dart';
import 'package:flutter_map_example/ui/home/home_page.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'denendency.dart';
import 'main.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late Future<void> _initialization;
  late Store<AppState> _store;

  @override
  void initState() {
    super.initState();
    _initialization = initialize();
  }

  Future<void> initialize() async {
    await initializeDependencies();
    _store = serviceLocator.get();
    _store.dispatch(const InitialAction());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: serviceLocator.get(),
      title: 'Flutter Demo',
      theme: AppTheme.themeLight,
      darkTheme: AppTheme.themeDark,
      home: FutureBuilder<void>(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              final error = snapshot.error.toString();
              logger.warning(error.toString(), error, snapshot.stackTrace);
              return buildInitError(error);
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return buildHome();
            }
            return buildInitLoader();
          }),
    );
  }

  Material buildInitError(String error) {
    return Material(
      child: Center(
        child: Text(error),
      ),
    );
  }

  Material buildInitLoader() {
    return const Material(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget buildHome() {
    return StoreProvider(
      store: _store,
      child: const HomePage(),
    );
  }
}
