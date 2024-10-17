import 'package:flutter/material.dart';
import 'create_account_loading_screen.dart';

class ReferralCodeScreen extends StatefulWidget {
  const ReferralCodeScreen({super.key});

  @override
  _ReferralCodeScreenState createState() => _ReferralCodeScreenState();
}

class _ReferralCodeScreenState extends State<ReferralCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController referralCodeController = TextEditingController();

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
                            color: index <= 5 ? theme.primaryColor : Colors.grey[350],
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
                      "Referral Code",
                      style: TextStyle(color: theme.primaryColor, fontSize: 25),
                    ),
                    Expanded(child: Container()),
                    Text(
                      "Skip",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(height: 50),

                // Referral Code Field
                TextFormField(
                  controller: referralCodeController,
                  decoration: InputDecoration(
                    hintText: "Enter Referral Code",
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a referral code';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle referral code submission logic here
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Referral code submitted successfully!')),
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CreateAccountLoadingScreen()));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      "Submit",
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
