import 'package:flutter/material.dart';
import 'package:rent_home/screens/Auth/house_agreement_screen.dart';

class EmergencyNumberScreen extends StatefulWidget {
  const EmergencyNumberScreen({super.key});

  @override
  _EmergencyNumberScreenState createState() => _EmergencyNumberScreenState();
}

class _EmergencyNumberScreenState extends State<EmergencyNumberScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emergencyNumberController = TextEditingController();
  String _selectedCountryCode = '+91'; // Default country code

  final List<String> countryCodes = ['+91', '+1', '+44', '+61', '+81'];

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
                          height: 6,
                          width: (w - 48) / 5 - 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: index <= 2 ? theme.primaryColor : Colors.grey[350],
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
                    SizedBox(width: 10),
                    Text(
                      "Emergency Number",
                      style: TextStyle(color: theme.primaryColor, fontSize: 25),
                    ),
                  ],
                ),
                SizedBox(height: 50),

                // Country Code and Emergency Number Field with error handling
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 58, // Set height equal to TextFormField
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100], // Match the fill color of TextFormField
                            borderRadius: BorderRadius.circular(12.0), // Match border radius
                            border: Border.all(color: Colors.transparent),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedCountryCode,
                              items: countryCodes
                                  .map<DropdownMenuItem<String>>(
                                      (String code) => DropdownMenuItem<String>(
                                    value: code,
                                    child: Text(code),
                                  ))
                                  .toList(),
                              onChanged: (String? newCode) {
                                setState(() {
                                  _selectedCountryCode = newCode!;
                                });
                              },
                              style: TextStyle(color: Colors.black, fontSize: 16),
                              dropdownColor: Colors.white,
                              icon: Icon(Icons.arrow_drop_down), // Dropdown icon
                              isDense: true, // Reduces the height of the dropdown menu
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: emergencyNumberController,
                            decoration: InputDecoration(
                              hintText: "Enter Emergency Number",
                              filled: true,
                              fillColor: Colors.grey[100],
                              contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an emergency number';
                              }
                              if (value.length < 10) {
                                return 'Emergency number must be at least 10 digits';
                              }
                              return null;
                            },
                            // Manage the height of the error text
                            style: TextStyle(height: 1.5),
                            strutStyle: StrutStyle(height: 0.7), // Reduce space taken by error text
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle save logic here
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Emergency number saved successfully!')),
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    HouseAgreementScreen()));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      "Save",
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
