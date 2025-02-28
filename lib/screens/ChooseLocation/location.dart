// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:phone_accessories_shop/components/custom_button.dart';
import 'package:phone_accessories_shop/data/models/cart_item_database.dart';
import 'package:phone_accessories_shop/theme/colors_theme.dart';
import 'package:phone_accessories_shop/theme/text_theme.dart';

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

  void _updateMarkers(LatLng position) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('current_location_marker'),
          position: position,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        ),
      );
    });
  }

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

      if (_mapController != null) {
        _mapController.animateCamera(
          CameraUpdate.newLatLng(_currentPosition),
        );
      }
    });
  }

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

  void _confirmLocation() async {
    // Save location to database
    await CartItemDatabase().addLocation(
      _selectedAddress,
      _currentPosition.latitude,
      _currentPosition.longitude,
    );

    Navigator.pop(context, {
      'lat': _currentPosition.latitude,
      'lng': _currentPosition.longitude,
      'address': _selectedAddress,
    });

    // Optionally, show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: secondaryColor,
        content: Text(
          "Location saved successfully!",
          style: TextStyle(color: backgroundColor),
        ),
      ),
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
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: Text(
          'Select Location',
          style: AppTextStyles.getSubtitleSize(),
        ),
        automaticallyImplyLeading: false,
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              backgroundColor: thirdColor,
              radius: 24,
              child: Image.asset(
                'assets/icon/arrowleft.png',
                scale: 1.5,
              ),
            ),
          ),
        ),
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
              padding: const EdgeInsets.only(top: 4.0),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 5,
                    color: placeholderColor,
                    spreadRadius: 0,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: GooglePlaceAutoCompleteTextField(
                boxDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                textEditingController: _searchController,
                googleAPIKey: "AIzaSyDIhT-WxaBN9HK5xR1H_HeEsr8Uxmvlpyo",
                inputDecoration: InputDecoration(
                  hintText: "Search location...",
                  hintStyle: AppTextStyles.getPlaceholderSize(),
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search, color: placeholderColor),
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
            left: 16,
            right: 16,
            child: SizedBox(
              width: double.infinity,
              child: CustomButton(
                  textButton: 'Confirm', onTapAction: _confirmLocation),
            ),
          ),
        ],
      ),
    );
  }
}
