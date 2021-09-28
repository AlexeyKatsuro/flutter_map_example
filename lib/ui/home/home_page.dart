import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_example/data/model/place_model.dart';
import 'package:flutter_map_example/domain/redux/app/app_state.dart';
import 'package:flutter_map_example/domain/redux/home/home_actions.dart';
import 'package:flutter_map_example/domain/redux/home/home_selectors.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final MapController _mapController = MapController();

  // Workaround to send event into ViewModel through single StreamSubscription
  _ViewModel? _currentViewModel;

  late StreamSubscription mapEventSubscription;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    mapEventSubscription = _mapController.mapEventStream.listen((event) {
      _currentViewModel?.onMapEvent(event);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    mapEventSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.formStore,
      onWillChange: (previousViewModel, newViewModel) {
        if (previousViewModel?.selectedPlace != newViewModel.selectedPlace) {
          final selectedPlace = newViewModel.selectedPlace;
          _controller.text = selectedPlace?.displayName ?? '';
          if (selectedPlace != null) {
            _mapController.fitBounds(LatLngBounds.fromPoints(selectedPlace.boundingBox));
          }
        }
      },
      builder: _build,
    );
  }

  Widget _build(BuildContext context, _ViewModel viewModel) {
    // Don't use this VM, it used only for mapEventSubscription
    _currentViewModel = viewModel;
    return Scaffold(
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(),
        layers: [
          TileLayerOptions(
            minZoom: 1,
            maxZoom: 18,
            backgroundColor: Colors.black,
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(markers: [
            if (viewModel.selectedPlace != null)
              Marker(
                point: viewModel.selectedPlace!.point,
                builder: (context) => const Icon(
                  Icons.place,
                  size: 48,
                ),
              ),
          ])
        ],
      ),
      // Hack to make the snack bar draw over bottomSheet
      floatingActionButton: const SizedBox(width: 1, height: 1),
      bottomSheet: Material(
        child: Form(
          key: _formKey,
          child: Container(
            height: 150,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Center(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Search place',
                  suffixIcon: buildSuffixIcon(viewModel),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onFieldSubmitted: (newValue) {
                  if (_formKey.currentState!.validate()) {
                    viewModel.onSearchSubmitted(newValue);
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSuffixIcon(_ViewModel viewModel) {
    final Widget icon;
    if (viewModel.isLoading) {
      icon = const SizedBox(
        key: Key('progress'),
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    } else if (viewModel.selectedPlace != null) {
      icon = IconButton(onPressed: viewModel.onClearField, icon: const Icon(Icons.clear_rounded));
    } else {
      icon = const SizedBox.shrink();
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: icon,
    );
  }
}

class _ViewModel extends Equatable {
  const _ViewModel({
    required this.isLoading,
    required this.selectedPlace,
    required this.onSearchSubmitted,
    required this.onMapEvent,
    required this.onClearField,
  });

  static _ViewModel formStore(Store<AppState> store) {
    var selectedPlace = selectedPlaceSelector(store.state);
    return _ViewModel(
      isLoading: isLoadingSelector(store.state),
      selectedPlace: selectedPlace,
      onSearchSubmitted: (query) => store.dispatch(SearchRequestAction(query)),
      onClearField: () => store.dispatch(const ClearSelectedPlaceAction()),
      onMapEvent: (event) {
        if (selectedPlace != null &&
            event is MapEventMove &&
            event.source == MapEventSource.onDrag) {
          store.dispatch(const ClearSelectedPlaceAction());
        }
      },
    );
  }

  final bool isLoading;
  final PlaceModel? selectedPlace;
  final ValueSetter<String> onSearchSubmitted;
  final ValueSetter<MapEvent> onMapEvent;
  final VoidCallback onClearField;

  @override
  List<Object?> get props => [isLoading, selectedPlace];
}
