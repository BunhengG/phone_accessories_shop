// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:phone_accessories_shop/data/models/cart_item_database.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  late GoogleMapController _mapController;
  LatLng _currentPosition = const LatLng(11.5564, 104.9282);
  Set<Marker> _markers = {};
  final TextEditingController _searchController = TextEditingController();
  String _selectedAddress = "Fetching location...";

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _trackLiveLocation();
  }

  //! Get current device location (Initial Fetch)
  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      String address =
          await _getAddressFromLatLng(position.latitude, position.longitude);

      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _selectedAddress = address;
        _updateMarkers(_currentPosition);
      });

      _mapController.animateCamera(
        CameraUpdate.newLatLngZoom(_currentPosition, 18),
      );
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  Future<String> _getAddressFromLatLng(double lat, double lng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      return "${place.street}, ${place.subLocality}, ${place.locality}";
    }
    return "Unknown Location";
  }

  // Update the marker for the current location
  void _updateMarkers(LatLng position) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('current_location_marker'),
          position: position,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    });
  }

  // Track live location updates
  void _trackLiveLocation() {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((Position position) {
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _updateMarkers(_currentPosition);
      });

      // Only animate the camera if the controller is ready
      if (_mapController != null) {
        _mapController.animateCamera(
          CameraUpdate.newLatLng(_currentPosition),
        );
      }
    });
  }

  // Handle when a user selects a place from search
  void _onPlaceSelected(dynamic place) async {
    double latitude = place['lat'];
    double longitude = place['lng'];
    String address = place['description'];

    LatLng newLocation = LatLng(latitude, longitude);

    setState(() {
      _currentPosition = newLocation;
      _selectedAddress = address;
      _updateMarkers(newLocation);
    });

    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(newLocation, 18),
    );
  }

  // Confirm the location and store it in the database
  void _confirmLocation() async {
    // Save location to database
    await CartItemDatabase().addLocation(
      _selectedAddress,
      _currentPosition.latitude,
      _currentPosition.longitude,
    );

    // Pop the selected location back to the previous screen
    Navigator.pop(context, {
      'lat': _currentPosition.latitude,
      'lng': _currentPosition.longitude,
      'address': _selectedAddress,
    });

    // Optionally, show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Location saved successfully!")),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (_currentPosition != null) {
      _mapController.animateCamera(
        CameraUpdate.newLatLngZoom(_currentPosition, 18),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Select Location'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _currentPosition,
              zoom: 18,
            ),
            markers: _markers,
          ),

          // Search Bar
          Positioned(
            top: 15,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: GooglePlaceAutoCompleteTextField(
                textEditingController: _searchController,
                googleAPIKey: "AIzaSyDIhT-WxaBN9HK5xR1H_HeEsr8Uxmvlpyo",
                inputDecoration: const InputDecoration(
                  hintText: "Search location...",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.blue),
                ),
                debounceTime: 500,
                countries: const ["KH"],
                isLatLngRequired: true,
                getPlaceDetailWithLatLng: _onPlaceSelected,
              ),
            ),
          ),

          // Confirm Button
          Positioned(
            bottom: 30,
            left: 50,
            right: 50,
            child: ElevatedButton(
              onPressed: _confirmLocation,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text("Confirm Location",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
