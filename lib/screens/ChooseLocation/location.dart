// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:geolocator/geolocator.dart';
// import 'package:phone_accessories_shop/theme/colors_theme.dart';

// import '../../theme/text_theme.dart';

// class SelectLocationScreen extends StatefulWidget {
//   const SelectLocationScreen({super.key});

//   @override
//   State<SelectLocationScreen> createState() => _SelectLocationScreenState();
// }

// class _SelectLocationScreenState extends State<SelectLocationScreen> {
//   late GoogleMapController _mapController;
//   BitmapDescriptor _markerIcon = BitmapDescriptor.defaultMarker;
//   final LatLng _staticMarkerPosition =
//       const LatLng(13.350918350149795, 103.86433962916841);
//   LatLng _currentPosition =
//       const LatLng(13.350918350149795, 103.86433962916841);
//   bool _isLocationReady = false;

//   // Markers
//   Set<Marker> _markers = {};

//   @override
//   void initState() {
//     super.initState();
//     _loadCustomIcon();
//     _getCurrentLocation();
//   }

//   // Load custom icon for static marker
//   void _loadCustomIcon() async {
//     BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(),
//       'assets/img/logo.png',
//     ).then((markerIcon) {
//       setState(() {
//         _markerIcon = markerIcon;
//         _updateMarkers();
//       });
//     });
//   }

//   // Get current device location
//   void _getCurrentLocation() async {
//     LocationPermission permission = await Geolocator.requestPermission();

//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Handle error, show message to user about enabling location
//       return;
//     }

//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);

//     setState(() {
//       _currentPosition = LatLng(position.latitude, position.longitude);
//       _isLocationReady = true;
//       _updateMarkers();
//     });

//     // Ensure the map controller is initialized before animating the camera
//     _mapController.animateCamera(
//       CameraUpdate.newLatLngZoom(_currentPosition, 18),
//     );
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     _mapController = controller;
//     // Animate the camera only after the location is ready
//     if (_isLocationReady) {
//       _mapController.animateCamera(
//         CameraUpdate.newLatLngZoom(_currentPosition, 18),
//       );
//     }
//   }

//   // Update markers
//   void _updateMarkers() {
//     _markers = {
//       // Static marker (using custom icon)
//       Marker(
//         markerId: const MarkerId('static_marker'),
//         position: _staticMarkerPosition,
//         icon: _markerIcon,
//       ),
//       // Dynamic marker (following current device location)
//       Marker(
//         markerId: const MarkerId('current_location_marker'),
//         position: _currentPosition,
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//       ),
//     };
//   }

//   void _zoomIn() {
//     _mapController.animateCamera(CameraUpdate.zoomIn());
//   }

//   void _zoomOut() {
//     _mapController.animateCamera(CameraUpdate.zoomOut());
//   }

//   MapType _currentMapType = MapType.normal;

//   void _onMapTypeButtonPressed() {
//     setState(() {
//       _currentMapType = _currentMapType == MapType.normal
//           ? MapType.satellite
//           : MapType.normal;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: backgroundColor,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         leading: Padding(
//           padding: const EdgeInsets.all(5.0),
//           child: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: CircleAvatar(
//               backgroundColor: thirdColor,
//               radius: 28,
//               child: Image.asset(
//                 'assets/icon/arrowleft.png',
//                 scale: 1.5,
//               ),
//             ),
//           ),
//         ),
//         title: Text('Location', style: AppTextStyles.getSubtitleSize()),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             zoomControlsEnabled: false,
//             onMapCreated: _onMapCreated,
//             mapType: _currentMapType,
//             initialCameraPosition: CameraPosition(
//               target: _currentPosition,
//               zoom: 18,
//             ),
//             markers: _markers,
//             circles: {
//               Circle(
//                 circleId: const CircleId("1"),
//                 // center: _currentPosition,
//                 center: _staticMarkerPosition,
//                 radius: 46,
//                 strokeWidth: 2,
//                 strokeColor: primaryColor,
//                 fillColor: primaryColor.withOpacity(0.2),
//               ),
//             },
//           ),
//           _buildZoomController(),
//         ],
//       ),
//     );
//   }

//   Widget _buildZoomController() {
//     return Positioned(
//       top: 20,
//       right: 5,
//       child: Column(
//         children: [
//           ElevatedButton(
//             onPressed: _onMapTypeButtonPressed,
//             style: ElevatedButton.styleFrom(
//               foregroundColor: thirdColor,
//               backgroundColor: primaryColor,
//               shape: const CircleBorder(),
//               padding: const EdgeInsets.all(8),
//               elevation: 4,
//             ),
//             child: const Icon(Icons.layers),
//           ),
//           ElevatedButton(
//             onPressed: _zoomIn,
//             style: ElevatedButton.styleFrom(
//               foregroundColor: thirdColor,
//               backgroundColor: primaryColor,
//               shape: const CircleBorder(),
//               padding: const EdgeInsets.all(8),
//               elevation: 4,
//             ),
//             child: const Icon(Icons.add),
//           ),
//           ElevatedButton(
//             onPressed: _zoomOut,
//             style: ElevatedButton.styleFrom(
//               foregroundColor: thirdColor,
//               backgroundColor: primaryColor,
//               shape: const CircleBorder(),
//               padding: const EdgeInsets.all(8),
//               elevation: 4,
//             ),
//             child: const Icon(Icons.remove),
//           ),
//         ],
//       ),
//     );
//   }
// }

// ! Update

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:phone_accessories_shop/theme/colors_theme.dart';

import '../../theme/text_theme.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  late GoogleMapController _mapController;
  LatLng _currentPosition = const LatLng(0.0, 0.0);
  bool _isLocationReady = false;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _trackLiveLocation();
  }

  // Get current location (Initial Fetch)
  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return; // Exit if no permission
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _isLocationReady = true;
      _updateMarkers();
    });

    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(_currentPosition, 18),
    );
  }

  // Track live location updates
  void _trackLiveLocation() {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5, // Update location if moved by 5 meters
      ),
    ).listen((Position position) {
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _updateMarkers();
      });

      _mapController.animateCamera(
        CameraUpdate.newLatLng(_currentPosition),
      );
    });
  }

  // Update the marker for the current location
  void _updateMarkers() {
    setState(() {
      _markers.clear(); // Remove previous markers
      _markers.add(
        Marker(
          markerId: const MarkerId('current_location_marker'),
          position: _currentPosition,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (_isLocationReady) {
      _mapController.animateCamera(
        CameraUpdate.newLatLngZoom(_currentPosition, 18),
      );
    }
  }

  void _zoomIn() {
    _mapController.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() {
    _mapController.animateCamera(CameraUpdate.zoomOut());
  }

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              backgroundColor: thirdColor,
              radius: 28,
              child: Image.asset(
                'assets/icon/arrowleft.png',
                scale: 1.5,
              ),
            ),
          ),
        ),
        title: Text('Location', style: AppTextStyles.getSubtitleSize()),
      ),
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            onMapCreated: _onMapCreated,
            mapType: _currentMapType,
            initialCameraPosition: CameraPosition(
              target: _currentPosition,
              zoom: 18,
            ),
            markers: _markers,
          ),
          _buildZoomController(),
        ],
      ),
    );
  }

  Widget _buildZoomController() {
    return Positioned(
      top: 20,
      right: 5,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: _onMapTypeButtonPressed,
            style: ElevatedButton.styleFrom(
              foregroundColor: thirdColor,
              backgroundColor: primaryColor,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(8),
              elevation: 4,
            ),
            child: const Icon(Icons.layers),
          ),
          ElevatedButton(
            onPressed: _zoomIn,
            style: ElevatedButton.styleFrom(
              foregroundColor: thirdColor,
              backgroundColor: primaryColor,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(8),
              elevation: 4,
            ),
            child: const Icon(Icons.add),
          ),
          ElevatedButton(
            onPressed: _zoomOut,
            style: ElevatedButton.styleFrom(
              foregroundColor: thirdColor,
              backgroundColor: primaryColor,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(8),
              elevation: 4,
            ),
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
