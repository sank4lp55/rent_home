import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  LatLng? currentPosition;
  Map<String, Marker> markers = {};
  BitmapDescriptor? icon;

  // Sample list of hotels with their location and price
  List<Map<String, dynamic>>? hotels;

  @override
  @override
  void initState() {
    super.initState();
    getIcon();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    await _getCurrentLocation();
    setHotelCoordinates();
    _addHotelMarkers();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
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

    // markers['current_location'] = Marker(
    //   markerId: const MarkerId('current_location'),
    //   position: currentPosition!,
    //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    //   infoWindow: const InfoWindow(title: "Your Location"),
    // );
    print(markers);
    setState(() {});
  }




  void setHotelCoordinates() {
    final Random random = Random();

    // Helper function to generate a small random offset
    double _generateOffset() {
      return (random.nextDouble() - 0.5) * 0.005;  // Small offset between -0.0005 and 0.0005
    }

    hotels = [
      {
        "name": "Hotel 1",
        "price": "\$150",
        "lat": (currentPosition?.latitude ?? 37.42796133580664) + _generateOffset(),
        "lng": (currentPosition?.longitude ?? -122.085749655962) + _generateOffset(),
      },
      {
        "name": "Hotel 2",
        "price": "\$200",
        "lat": (currentPosition?.latitude ?? 37.43096133580664) + _generateOffset(),
        "lng": (currentPosition?.longitude ?? -122.088749655962) + _generateOffset(),
      },
      {
        "name": "Hotel 3",
        "price": "\$180",
        "lat": (currentPosition?.latitude ?? 37.42496133580664) + _generateOffset(),
        "lng": (currentPosition?.longitude ?? -122.084749655962) + _generateOffset(),
      },
      {
        "name": "Hotel 4",
        "price": "\$180",
        "lat": (currentPosition?.latitude ?? 37.42496133580664) + _generateOffset(),
        "lng": (currentPosition?.longitude ?? -122.084749655962) + _generateOffset(),
      },
      {
        "name": "Hotel 5",
        "price": "\$180",
        "lat": (currentPosition?.latitude ?? 37.42496133580664) + _generateOffset(),
        "lng": (currentPosition?.longitude ?? -122.084749655962) + _generateOffset(),
      },
      {
        "name": "Hotel 6",
        "price": "\$180",
        "lat": (currentPosition?.latitude ?? 37.42496133580664) + _generateOffset(),
        "lng": (currentPosition?.longitude ?? -122.084749655962) + _generateOffset(),
      },
    ];
  }
  void _addHotelMarkers() {
    for (var hotel in hotels ?? []) {
      markers[hotel['name']] = Marker(
        markerId: MarkerId(hotel['name']),
        position: LatLng(hotel['lat'], hotel['lng']),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: InfoWindow(
          title: hotel['name'],
          snippet: hotel['price'], // Display the price of the hotel
          onTap: () {
            _showHotelDetails(hotel['name'], hotel['price']);
          },
        ),
      );
    }
    print(markers);
    setState(() {});
  }

  // Function to display hotel details in a pop-up
  void _showHotelDetails(String name, String price) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(name),
          content: Text("Price: $price"),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            compassEnabled: true,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: markers.values.toSet(),
            padding:
                const EdgeInsets.only(top: 20), // Adjust this value as needed
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 20,
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Center(
                        child: Text(
                          "Search this area",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  getIcon() async {
    icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 3.2), "assets/car.png");

    setState(() {});
  }
}
