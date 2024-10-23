import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../screens/property_page.dart';

class HotelDialog extends StatelessWidget {
  String name;
  String price;
  List<String> imageUrls;
  String description;
  String rating;

  HotelDialog(
      {super.key,
      required this.name,
      required this.price,
      required this.imageUrls,
      required this.description,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          // Align all contents to the left
          children: [
            // Carousel Slider for Images
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => PropertyPage(
                          image: imageUrls[0],
                          name: name,
                          description: description,
                          rating: rating,
                          price: price,
                          galleryImages: imageUrls,
                        )));
              },
              child: Container(
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
                        child: CachedNetworkImage(
                          imageUrl: url,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          placeholder: (context, url) => _buildShimmerEffect(),
                          // Placeholder while loading
                          errorWidget: (context, url, error) => Icon(Icons
                              .error), // Error widget if the image fails to load
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Hotel Name and Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // Distribute space between name and rating
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => PropertyPage(
                              image: imageUrls[0],
                              name: name,
                              description: description,
                              rating: rating,
                              price: price,
                              galleryImages: imageUrls,
                            )));
                  },
                  child: Expanded(
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
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => PropertyPage(
                          image: imageUrls[0],
                          name: name,
                          description: description,
                          rating: rating,
                          price: price,
                          galleryImages: imageUrls,
                        )));
              },
              child: Text(
                "Price: $price",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                textAlign: TextAlign.left, // Left-align the price
              ),
            ),
            const SizedBox(height: 10),

            // Hotel Description
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => PropertyPage(
                          image: imageUrls[0],
                          name: name,
                          description: description,
                          rating: rating,
                          price: price,
                          galleryImages: imageUrls,
                        )));
              },
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.left, // Left-align the description
              ),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        // Align icons and text to the left
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
                  child: InkWell(
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.4)),
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // Align icons and text to the left
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
  }

  // Shimmer Effect Widget
  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
