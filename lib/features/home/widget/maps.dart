import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

// import '../../../constants.dart';

class MapsWidget extends StatefulWidget {
  const MapsWidget({super.key});

  @override
  State<MapsWidget> createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  StreamSubscription? _locationSubscription;
  final Location _locationTracker = Location();
  Marker? marker;
  Marker? pinPointMarker;
  Circle? circle;
  late GoogleMapController _controller;

  static const LatLng pinPoint = LatLng(-6.193018900134896, 106.56909271089695);

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude!, newLocalData.longitude!);
    setState(() {
      marker = Marker(
        markerId: const MarkerId("currentLocation"),
        position: latlng,
        icon: BitmapDescriptor.fromBytes(imageData),
      );
      pinPointMarker = Marker(
        markerId: const MarkerId("pinPoint"),
        position: LatLng(pinPoint.latitude, pinPoint.longitude),
        icon: BitmapDescriptor.fromBytes(imageData),
      );
    });
  }

  void getCurrentLocation() async {
    try {
      Uint8List imageData =
          await getBytesFromAsset('assets/images/pin.png', 100);
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription!.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
        _controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(newLocalData.latitude!, newLocalData.longitude!),
              zoom: 17,
            ),
          ),
        );
        updateMarkerAndCircle(newLocalData, imageData);
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(
          pinPoint.latitude,
          pinPoint.longitude,
        ),
        zoom: 17,
      ),
      zoomControlsEnabled: false,
      buildingsEnabled: false,
      compassEnabled: false,
      circles: {
        Circle(
          circleId: const CircleId('radius'),
          center: pinPoint,
          radius: 300,
          strokeColor: Colors.blue,
          strokeWidth: 2,
          fillColor: Colors.blue.withOpacity(0.2),
        ),
      },
      markers: Set.of(
        (marker != null)
            ? [
                marker!,
                pinPointMarker!,
              ]
            : [],
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
      },
    );
  }
}
