import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rent_home/widgets/hotel_dialog.dart';
import 'package:rent_home/widgets/search_area_button.dart';

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
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    await _getCurrentLocation();
    setHotelCoordinates();
    await _addHotelMarkers(); // await to ensure marker generation
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

    setState(() {});
  }

  void setHotelCoordinates() {
    final Random random = Random();
    // Helper function to generate a small random offset
    double _generateOffset() {
      print((random.nextDouble() - 0.5) * 0.005);
      print(
          "latitude: ${currentPosition!.latitude + (random.nextDouble() - 0.5) * 0.005}"
          "  longitude: ${currentPosition!.longitude + (random.nextDouble() - 0.5) * 0.005}");
      print("\n");
      return (random.nextDouble() - 0.5) * 0.005;
    }

    hotels = [
      {
        "name": "The Grand Palace Hotel",
        "price": "₹3000",
        "lat": (currentPosition?.latitude ?? 37.42796133580664) +
            _generateOffset(),
        "lng": (currentPosition?.longitude ?? -122.085749655962) +
            _generateOffset(),
        "description":
            "A luxurious hotel featuring spacious rooms and breathtaking views of the city skyline.",
        "rating": "5",
        "imageUrls": [
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/22/a1/9c/80/essentia-luxury-hotel.jpg?w=1200&h=-1&s=1",
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0f/17/09/c9/caption.jpg?w=700&h=-1&s=1",
          "https://media-cdn.tripadvisor.com/media/photo-s/10/da/a5/12/deluxe-room.jpg",
        ],
      },
      {
        "name": "Ocean Breeze Resort",
        "price": "₹4500",
        "lat": (currentPosition?.latitude ?? 37.43096133580664) +
            _generateOffset(),
        "lng": (currentPosition?.longitude ?? -122.088749655962) +
            _generateOffset(),
        "description":
            "An oceanfront resort with private beach access and premium spa services for ultimate relaxation.",
        "rating": "4",
        "imageUrls": [
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/22/a1/9c/80/essentia-luxury-hotel.jpg?w=1200&h=-1&s=1",
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0f/17/09/c9/caption.jpg?w=700&h=-1&s=1",
          "https://media-cdn.tripadvisor.com/media/photo-s/10/da/a5/12/deluxe-room.jpg",
        ],
      },
      {
        "name": "Mountain View ",
        "price": "₹2200",
        "lat": (currentPosition?.latitude ?? 37.42496133580664) +
            _generateOffset(),
        "lng": (currentPosition?.longitude ?? -122.084749655962) +
            _generateOffset(),
        "description":
            "A quaint inn nestled in the mountains, perfect for hikers and nature lovers.",
        "rating": "3",
        "imageUrls": [
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/22/a1/9c/80/essentia-luxury-hotel.jpg?w=1200&h=-1&s=1",
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0f/17/09/c9/caption.jpg?w=700&h=-1&s=1",
          "https://media-cdn.tripadvisor.com/media/photo-s/10/da/a5/12/deluxe-room.jpg",
        ],
      },
      {
        "name": "City Center Suites",
        "price": "₹3800",
        "lat": (currentPosition?.latitude ?? 37.42496133580664) +
            _generateOffset(),
        "lng": (currentPosition?.longitude ?? -122.084749655962) +
            _generateOffset(),
        "description":
            "Modern suites located in the heart of the city, close to major attractions.",
        "rating": "4",
        "imageUrls": [
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/22/a1/9c/80/essentia-luxury-hotel.jpg?w=1200&h=-1&s=1",
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0f/17/09/c9/caption.jpg?w=700&h=-1&s=1",
          "https://media-cdn.tripadvisor.com/media/photo-s/10/da/a5/12/deluxe-room.jpg",
        ],
      },
      {
        "name": "Cottage Retreat",
        "price": "₹2900",
        "lat": (currentPosition?.latitude ?? 37.42496133580664) +
            _generateOffset(),
        "lng": (currentPosition?.longitude ?? -122.084749655962) +
            _generateOffset(),
        "description":
            "Charming cottage with a rustic feel, ideal for a quiet getaway.",
        "rating": "3",
        "imageUrls": [
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/22/a1/9c/80/essentia-luxury-hotel.jpg?w=1200&h=-1&s=1",
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0f/17/09/c9/caption.jpg?w=700&h=-1&s=1",
          "https://media-cdn.tripadvisor.com/media/photo-s/10/da/a5/12/deluxe-room.jpg",
        ],
      },
      {
        "name": "Eco Lodge",
        "price": "₹2100",
        "lat": (currentPosition?.latitude ?? 37.42496133580664) +
            _generateOffset(),
        "lng": (currentPosition?.longitude ?? -122.084749655962) +
            _generateOffset(),
        "description":
            "Sustainable lodge surrounded by nature, offering eco-friendly accommodations.",
        "rating": "4",
        "imageUrls": [
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/22/a1/9c/80/essentia-luxury-hotel.jpg?w=1200&h=-1&s=1",
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0f/17/09/c9/caption.jpg?w=700&h=-1&s=1",
          "https://media-cdn.tripadvisor.com/media/photo-s/10/da/a5/12/deluxe-room.jpg",
        ],
      },
      {
        "name": "The Grand Palace Hotel",
        "price": "₹3000",
        "lat": (currentPosition?.latitude ?? 37.42796133580664) +
            _generateOffset(),
        "lng": (currentPosition?.longitude ?? -122.085749655962) +
            _generateOffset(),
        "description":
            "A luxurious hotel featuring spacious rooms and breathtaking views of the city skyline.",
        "rating": "5",
        "imageUrls": [
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/22/a1/9c/80/essentia-luxury-hotel.jpg?w=1200&h=-1&s=1",
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0f/17/09/c9/caption.jpg?w=700&h=-1&s=1",
          "https://media-cdn.tripadvisor.com/media/photo-s/10/da/a5/12/deluxe-room.jpg",
        ],
      },
      {
        "name": "Ocean Breeze Resort inn",
        "price": "₹4500",
        "lat": (currentPosition?.latitude ?? 37.43096133580664) +
            _generateOffset(),
        "lng": (currentPosition?.longitude ?? -122.088749655962) +
            _generateOffset(),
        "description":
            "An oceanfront resort with private beach access and premium spa services for ultimate relaxation.",
        "rating": "4",
        "imageUrls": [
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/22/a1/9c/80/essentia-luxury-hotel.jpg?w=1200&h=-1&s=1",
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0f/17/09/c9/caption.jpg?w=700&h=-1&s=1",
          "https://media-cdn.tripadvisor.com/media/photo-s/10/da/a5/12/deluxe-room.jpg",
        ],
      },
      {
        "name": "Mountain View Inn",
        "price": "₹2200",
        "lat": (currentPosition?.latitude ?? 37.42496133580664) +
            _generateOffset(),
        "lng": (currentPosition?.longitude ?? -122.084749655962) +
            _generateOffset(),
        "description":
            "A quaint inn nestled in the mountains, perfect for hikers and nature lovers.",
        "rating": "3",
        "imageUrls": [
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/22/a1/9c/80/essentia-luxury-hotel.jpg?w=1200&h=-1&s=1",
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0f/17/09/c9/caption.jpg?w=700&h=-1&s=1",
          "https://media-cdn.tripadvisor.com/media/photo-s/10/da/a5/12/deluxe-room.jpg",
        ],
      },
      {
        "name": "City Center Suites inn",
        "price": "₹3800",
        "lat": (currentPosition?.latitude ?? 37.42496133580664) +
            _generateOffset(),
        "lng": (currentPosition?.longitude ?? -122.084749655962) +
            _generateOffset(),
        "description":
            "Modern suites located in the heart of the city, close to major attractions.",
        "rating": "4",
        "imageUrls": [
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/22/a1/9c/80/essentia-luxury-hotel.jpg?w=1200&h=-1&s=1",
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0f/17/09/c9/caption.jpg?w=700&h=-1&s=1",
          "https://media-cdn.tripadvisor.com/media/photo-s/10/da/a5/12/deluxe-room.jpg",
        ],
      },
      {
        "name": "Cottage Retreat inn",
        "price": "₹2900",
        "lat": (currentPosition?.latitude ?? 37.42496133580664) +
            _generateOffset(),
        "lng": (currentPosition?.longitude ?? -122.084749655962) +
            _generateOffset(),
        "description":
            "Charming cottage with a rustic feel, ideal for a quiet getaway.",
        "rating": "3",
        "imageUrls": [
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/22/a1/9c/80/essentia-luxury-hotel.jpg?w=1200&h=-1&s=1",
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0f/17/09/c9/caption.jpg?w=700&h=-1&s=1",
          "https://media-cdn.tripadvisor.com/media/photo-s/10/da/a5/12/deluxe-room.jpg",
        ],
      },
      {
        "name": "Eco Lodge inn",
        "price": "₹2100",
        "lat": (currentPosition?.latitude ?? 37.42496133580664) +
            _generateOffset(),
        "lng": (currentPosition?.longitude ?? -122.084749655962) +
            _generateOffset(),
        "description":
            "Sustainable lodge surrounded by nature, offering eco-friendly accommodations.",
        "rating": "4",
        "imageUrls": [
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/22/a1/9c/80/essentia-luxury-hotel.jpg?w=1200&h=-1&s=1",
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0f/17/09/c9/caption.jpg?w=700&h=-1&s=1",
          "https://media-cdn.tripadvisor.com/media/photo-s/10/da/a5/12/deluxe-room.jpg",
        ],
      },
    ];
  }

  Future<void> _addHotelMarkers() async {
    for (var hotel in hotels ?? []) {
      final markerIcon = await _createCustomMarkerWithPrice(hotel['price']);
      markers[hotel['name']] = Marker(
        markerId: MarkerId(hotel['name']),
        position: LatLng(hotel['lat'], hotel['lng']),
        icon: markerIcon,
        onTap: () {
          // Directly show the dialog when the marker is tapped
          _showHotelDetails(
            hotel['name'],
            hotel['price'],
            hotel['imageUrls'],
            hotel['description'],
            hotel['rating'],
          );
        },
      );
    }
    setState(() {});
  }

  Future<BitmapDescriptor> _createCustomMarkerWithPrice(String price) async {
    final PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    const double size = 140.0;

    // Draw a rectangle with rounded corners and fill with a color
    final Paint paint = Paint()..color = Theme.of(context).primaryColor;
    final RRect rRect = RRect.fromRectAndRadius(
      const Rect.fromLTWH(0.0, 0.0, size, size / 2), // Define the rectangle
      const Radius.circular(size / 4), // Apply the border radius here
    );
    canvas.drawRRect(rRect, paint);

    // Draw the price text
    final TextPainter textPainter = TextPainter(
      textDirection: ui.TextDirection.ltr,
    );
    textPainter.text = TextSpan(
      text: price,
      style: const TextStyle(
        fontSize: 35.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset(
          (size - textPainter.width) / 2, // center the text horizontally
          (size / 4 - textPainter.height / 2), // center the text vertically
        ));

    final img = await pictureRecorder
        .endRecording()
        .toImage(size.toInt(), (size / 2).toInt());
    final data = await img.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }

  //hotel dialog
  void _showHotelDetails(String name, String price, List<String> imageUrls,
      String description, String rating) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return HotelDialog(name: name,price: price,imageUrls: imageUrls,description: description,rating: rating,);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
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
                const EdgeInsets.only(top: 50), // Adjust this value as needed
          ),
          // Stack(
          //   alignment: Alignment.center,
          //   children: [
          //     Positioned(bottom: 20, child: SearchButton()),
          //   ],
          // ),
        ],
      ),
    );
  }
}
