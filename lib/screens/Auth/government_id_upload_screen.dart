import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_home/screens/Auth/emergency_number_screen.dart';

class GovernmentIdScreen extends StatefulWidget {
  const GovernmentIdScreen({super.key});

  @override
  _GovernmentIdScreenState createState() => _GovernmentIdScreenState();
}

class _GovernmentIdScreenState extends State<GovernmentIdScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController idNumberController = TextEditingController();
  XFile? _idImage;

  Future<void> _pickIdImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _idImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final w = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(5, (index) {
                        return Container(
                          height: 6, // Height of each container
                          width: (w - 48) / 5 - 10, // Width of each container
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: index <= 1
                                ? theme.primaryColor
                                : Colors.grey[350],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: theme.primaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Text(
                        "Upload Government ID",
                        style:
                        TextStyle(color: theme.primaryColor, fontSize: 25),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),

                // Centered Image Picker for Government ID
                GestureDetector(
                  onTap: _pickIdImage,
                  child: Container(
                    height: 150,
                    width: w * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15), // Keep the border radius
                      color: Colors.grey[300],
                    ),
                    child: ClipRRect( // Clip the image to match the container's rounded corners
                      borderRadius: BorderRadius.circular(15), // Ensure it matches the container's radius
                      child: _idImage == null
                          ? const Icon(Icons.picture_as_pdf, color: Colors.grey) // Placeholder icon
                          : Image.file(
                        File(_idImage!.path),
                        fit: BoxFit.cover, // Fill the container while maintaining aspect ratio
                        width: w * 0.7, // Ensure image respects width
                        height: 150, // Ensure image respects height
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 5),
                GestureDetector(
                  onTap: _pickIdImage,
                  child: Container(
                    child: Text(
                      "Upload your Government ID",
                      style: TextStyle(color: theme.primaryColor),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Government ID Number Field with validation
                TextFormField(
                  controller: idNumberController,
                  decoration: InputDecoration(
                    hintText: "Government ID Number",
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your government ID number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // Upload Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_idImage != null) {
                          // Handle upload logic here
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Government ID uploaded successfully!')),
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      EmergencyNumberScreen()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Please select a government ID image.')),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      "Next",
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
