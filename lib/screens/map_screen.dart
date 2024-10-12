import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui; // For custom marker rendering
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
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
      return (random.nextDouble() - 0.5) * 0.005;
    }

    hotels = [
      {
        "name": "The Grand Palace Hotel",
        "price": "₹3000",
        "lat": (currentPosition?.latitude ?? 37.42796133580664) + _generateOffset(),
        "lng": (currentPosition?.longitude ?? -122.085749655962) + _generateOffset(),
        "description": "A luxurious hotel featuring spacious rooms and breathtaking views of the city skyline.",
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
        "lat": (currentPosition?.latitude ?? 37.43096133580664) + _generateOffset(),
        "lng": (currentPosition?.longitude ?? -122.088749655962) + _generateOffset(),
        "description": "An oceanfront resort with private beach access and premium spa services for ultimate relaxation.",
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
        "lat": (currentPosition?.latitude ?? 37.42496133580664) + _generateOffset(),
        "lng": (currentPosition?.longitude ?? -122.084749655962) + _generateOffset(),
        "description": "A quaint inn nestled in the mountains, perfect for hikers and nature lovers.",
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
        "lat": (currentPosition?.latitude ?? 37.42496133580664) + _generateOffset(),
        "lng": (currentPosition?.longitude ?? -122.084749655962) + _generateOffset(),
        "description": "Modern suites located in the heart of the city, close to major attractions.",
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
        "lat": (currentPosition?.latitude ?? 37.42496133580664) + _generateOffset(),
        "lng": (currentPosition?.longitude ?? -122.084749655962) + _generateOffset(),
        "description": "Charming cottage with a rustic feel, ideal for a quiet getaway.",
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
        "lat": (currentPosition?.latitude ?? 37.42496133580664) + _generateOffset(),
        "lng": (currentPosition?.longitude ?? -122.084749655962) + _generateOffset(),
        "description": "Sustainable lodge surrounded by nature, offering eco-friendly accommodations.",
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
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start, // Align all contents to the left
              children: [
                // Carousel Slider for Images
                Container(
                  // height: 200, // Adjust the height as necessary
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 170.0,
                      enlargeCenterPage: false,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                    ),
                    items: imageUrls.map((url) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Image.network(
                            url,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 10),

                // Hotel Name and Rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute space between name and rating
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.left, // Left-align the hotel name
                      ),
                    ),
                    // Show star and numeric rating
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20, // Adjust star size if necessary
                        ),
                        const SizedBox(width: 5),
                        Text(
                          rating,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Hotel Price
                Text(
                  "Price: $price",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left, // Left-align the price
                ),
                const SizedBox(height: 10),

                // Hotel Description
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.left, // Left-align the description
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.4)),
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, // Align icons and text to the left
                            children: [
                              Icon(
                                Icons.people_alt_outlined,
                                size: 15,
                              ),
                              SizedBox(width: 5),
                              Text("IN/2G")
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.4)),
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, // Align icons and text to the left
                            children: [
                              Icon(
                                Icons.calendar_month_outlined,
                                size: 15,
                              ),
                              SizedBox(width: 5),
                              Text("Oct 12 - 13")
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
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
}
