import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AkunPage extends StatelessWidget {
  const AkunPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage('https://s-light.tiket.photos/t/01E25EBZS3W0FY9GTG6C42E1SE/original/test-discovery/2023/09/26/d489d5c6-8597-44e2-a9cf-c5e29d27981c-1695715946585-9efe2fdb996b98897024f9c8b2d522b8.png'), // replace with your network image URL
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: GoogleFonts.patrickHand(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Akun',
                          style: GoogleFonts.patrickHand(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    // Add your settings action here
                  },
                ),
              ],
            ),
            SizedBox(height: 20), // Add some spacing
            Card(
              elevation: 0, // No shadow
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                title: Text(
                  'Mau Berjualan di POOPAY? Buka Toko',
                  style: GoogleFonts.patrickHand(fontSize: 14),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Add your navigation or action here
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
