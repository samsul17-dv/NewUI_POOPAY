import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int price;
  final String storeName;
  final int soldCount;
  final VoidCallback onTap;

  ProductItem({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.storeName,
    required this.soldCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        onTap: onTap,
        leading: Image.network(
          imageUrl,
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rp ${price.toStringAsFixed(0)}',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
            ),
            Text(
              storeName,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 10.0,
                  color: Colors.grey,
                ),
              ),
            ),
            Text(
              'Terjual: $soldCount',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 10.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
