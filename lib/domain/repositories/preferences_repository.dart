import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepository {
  static const _lastPlaceSearchQueryKey = 'last_place_search_query';

  final SharedPreferences _preferences;

  PreferencesRepository({required SharedPreferences preferences}) : _preferences = preferences;

  String? get lastPlaceSearchQuery => _preferences.getString(_lastPlaceSearchQueryKey);

  set lastPlaceSearchQuery(String? value) {
    if (value != null) {
      _preferences.setString(_lastPlaceSearchQueryKey, value);
    } else {
      _preferences.remove(_lastPlaceSearchQueryKey);
    }
  }
}
