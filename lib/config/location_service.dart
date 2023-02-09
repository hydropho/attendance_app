import 'dart:async';
import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationService {
  final Location _locationTracker = Location();
  int? distance;

  static const LatLng pinPoint = LatLng(-6.193018900134896, 106.56909271089695);
  // static const LatLng pinPoint = LatLng(-6.552553710080873, 106.82496471040072);

  Future<int> get getDistance async {
    LocationData? locationData;
    await _locationTracker
        .getLocation()
        .then((location) => locationData = location);

    return calculateDistance(pinPoint.latitude, pinPoint.longitude,
            locationData!.latitude, locationData!.longitude)
        .round();
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)) * 1000;
  }
}
