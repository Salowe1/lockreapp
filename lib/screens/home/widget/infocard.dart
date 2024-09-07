import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lockre/constants/colors.dart';
import 'contact_seller_screen.dart'; // Make sure to import your ContactSellerScreen

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(width: 2, color: AppColors.greyColor),
                  ),
                  child: Image.asset(
                    'assets/image/parcel.jpeg', // Chemin de l'image
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Column(  // Removed 'const' from here
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Parcelle à vendre à Karpala',
                      style: TextStyle(
                        fontSize: 14, 
                        color: Colors.grey,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 10), // Changed from width to height
                    const Text(
                      '6.000.000 FCFA',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                    const SizedBox(height: 10), // Changed from width to height
                    const Text(
                      '1 hectare',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: -3,
              right: 0,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(ContactSellerScreen());
                },
                style: ElevatedButton.styleFrom(
                  // Use 'backgroundColor' for Flutter 2.0 and above
                  // For older versions, replace with 'primary'
                  primary: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Intéressé",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
