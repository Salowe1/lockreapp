import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lockre/constants/colors.dart';
// import 'package:sms_autofill/sms_autofill.dart'; // Commented out
import 'complete_profile.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber; // Phone number to which OTP is sent
  final String verificationId; // Verification ID for the OTP process

  OTPScreen({Key? key, required this.phoneNumber, required this.verificationId}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> /* with CodeAutoFill */ { // Commented out
  String otpCode = ''; // Stores the OTP code entered or autofilled

  // This method is automatically called when the OTP code is updated (autofilled or manually entered).
  // @override
  // void codeUpdated() { // Commented out
  //   setState(() { // Commented out
  //     otpCode = code!; // Update the OTP code when the autofill service provides it // Commented out
  //   }); // Commented out
  // }

  // A function to show snack bars for notifications.
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // listenForCode(); // Start listening for the OTP code using the CodeAutoFill service // Commented out
  }

  @override
  void dispose() {
    // cancel(); // Stop listening for OTP code updates when the widget is disposed // Commented out
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, top: 30, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Image.asset('assets/logo/lockre.png', height: 200), // Display logo
            const SizedBox(height: 20),
            const Text(
              "Enter the OTP sent to your phone number",
              style: TextStyle(fontSize: 15, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                maxLength: 6,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter OTP',
                ),
                onChanged: (value) {
                  setState(() {
                    otpCode = value; // Update the OTP code as the user enters it
                  });
                },
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  bool verified = false; // Placeholder for the actual OTP verification logic
                  if (verified) {
                    // If OTP is verified, proceed to complete profile screen
                    Get.to(() => CompleteProfileScreen());
                  } else {
                    // If OTP verification fails, show an error message
                    showSnackBar('Invalid OTP');
                  }
                },
                child: const Text(
                  'Verify',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor, // Use primary color for the button
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
