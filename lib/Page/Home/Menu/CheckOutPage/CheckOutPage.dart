import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CheckoutPage extends StatelessWidget {
  final List<Map<String, String>> products; // Parameter yang diperbarui untuk menerima daftar produk
  final String quantity;

  const CheckoutPage({Key? key, required this.products, required this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fungsi untuk menghitung total harga dari daftar produk
    double totalPrice = _calculateTotalPrice();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Pengiriman',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white, // Set warna latar belakang menjadi putih
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Alamat Pengiriman Kamu',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              // Placeholder untuk detail alamat pengiriman, sesuaikan sesuai logika aplikasi Anda
              // Ganti dengan konten dinamis jika tersedia
              GestureDetector(
                onTap: () {

                },
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.blue),
                    SizedBox(width: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rumah - Samsul Muarif',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          'Jl. Pahlawan No. 123, Jakarta',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, size: 16.0),
                  ],
                ),
              ),
              SizedBox(height: 18.0),
              // Daftar produk dalam keranjang
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['store'] ?? '',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      product['imageUrl'] ?? '',
                                      height: 100.0,
                                      width: 100.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product['name'] ?? '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Row(
                                          children: [
                                            Text(
                                              'x$quantity', // Jumlah setiap produk
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              ' ${product['price'] ?? ''}', // Harga setiap produk
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                    ],
                  );
                },
              ),
              GestureDetector(
                onTap: () {
                  // Implementasi logika untuk memilih pengiriman
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Text(
                        'Pilih Pengiriman',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, size: 16.0),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                'Cek Ringkasan Belanjaan Yuk!',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Text(
                    'Total', // Ringkasan harga total
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),
                  Text(
                    NumberFormat.currency(
                      locale: 'id_ID',
                      symbol: 'Rp',
                      decimalDigits: 3,
                    ).format(totalPrice), // Tampilkan harga total dengan 3 tempat desimal
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Implementasi logika checkout
                    _handleCheckout(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.grey; // Warna saat tombol dinonaktifkan
                        }
                        return Colors.blue; // Warna saat tombol aktif
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(vertical: 20.0),
                    ),
                  ),
                  child: Text(
                    'Pilih Pembayaran',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Warna teks
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateTotalPrice() {
    // Fungsi untuk menghitung total harga dari daftar produk
    double totalPrice = 0;
    // Parse quantity untuk memastikan itu integer yang valid
    int parsedQuantity =
        int.tryParse(quantity.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

    for (var product in products) {
      // Ekstrak nilai numerik dari string harga
      String priceString =
          product['price'] ?? '0'; // Default ke '0' jika harga null
      priceString = priceString.replaceAll(
          RegExp(r'[^\d.]'), ''); // Hapus karakter non-numerik kecuali '.'
      double price = double.tryParse(priceString) ??
          0; // Parse string yang dibersihkan ke double, default ke 0 jika parsing gagal

      totalPrice += price * parsedQuantity; // Kalikan dengan jumlah yang diparsing
    }

    return totalPrice;
  }

  void _handleCheckout(BuildContext context) {
    // Penanganan logika checkout, misalnya, navigasi kembali ke layar sebelumnya
    Navigator.pop(context);
  }
}

