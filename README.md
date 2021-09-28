# Flutter map example

Flutter app for finding places on the map

## Overview

The [flutter_map](https://pub.dev/packages/flutter_map) library was used to work with maps in flutter

A OpenStreetMap search [request](https://nominatim.org/release-docs/develop/api/Search/) used to look up a location

### Preview
<p align="center">
<img src="data/screenshot_1.webp" width="32%"/>
<img src="data/screenshot_2.webp" width="32%"/>
<img src="data/screenshot_3.webp" width="32%"/>
</p>
<p align="center">
<img src="data/screenshot_1.webp" width="32%"/>
<img src="data/screenshot_2.webp" width="32%"/>
<img src="data/screenshot_3.webp" width="32%"/>
</p>

* Features
    * Search for a place by name or part of it
    * Displaying found places on the map
    * Saving the last found location after exiting the application
    * Clearing the found place when moving the map
* Edge cases
    * Input field validation(empty check)
    * Show error message if search request was failed
    * Show a message if the search didn't find anything

