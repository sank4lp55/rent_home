import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  LatLng? currentPosition;
  Map<String, Marker> usersCarArr = {};
  BitmapDescriptor? icon;

  @override
  void initState() {
    super.initState();
    getIcon();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        return Future.error('Location permissions are denied');
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
    });

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: currentPosition!, zoom: 16),
    ));

    usersCarArr['current_location'] = Marker(
      markerId: const MarkerId('current_location'),
      position: currentPosition!,
      icon: icon ?? BitmapDescriptor.defaultMarker,
      infoWindow: const InfoWindow(title: "Your Location"),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        compassEnabled: true,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: usersCarArr.values.toSet(),
        padding: EdgeInsets.only(top: 20), // Adjust this value as needed
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToCurrentLocation,
      //   label: const Text('My Location'),
      //   icon: const Icon(Icons.my_location),
      // ),
    );
  }

  Future<void> _goToCurrentLocation() async {
    if (currentPosition != null) {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: currentPosition!, zoom: 16),
      ));
    }
  }

  getIcon() async {
    icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 3.2), "assets/car.png");

    setState(() {});
  }
}
