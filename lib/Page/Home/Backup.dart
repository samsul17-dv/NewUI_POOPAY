import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:updateapkv2/Page/Home/Menu/Fashion.dart';
import 'package:updateapkv2/Page/Home/Menu/Gadget.dart';
import 'package:updateapkv2/Page/Home/Menu/GratisOngkir.dart';
import 'package:updateapkv2/Page/Home/Menu/MembershipPage.dart';
import 'package:updateapkv2/Page/Home/Menu/SaldoPage.dart';
import 'package:updateapkv2/Page/Home/Menu/SubPage.dart';
import 'package:updateapkv2/Page/Home/Menu/Travelling.dart';
import 'package:updateapkv2/Page/Home/SearchPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  final List<Map<String, String>> products = [
    {
      'name':
          'SABA Slip On Uplocgs Black Gum- Sepatu Sneakers Casual Pria Wanita',
      'price': 'Rp 114.000',
      'store': 'Saba Footwear Official Store',
      'sold': 'Terjual 1rb+',
      'imageUrl':
          'https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full/catalog-image/MTA-120840348/saba_saba_slip_on_uplocgs_black_gum-_sepatu_sneakers_casual_pria_wanita_full01_jqpefmvu.jpg',
    },
    {
      'name':
          'SABA Veron Low Pro Ice Black - Sepatu Sneakers Casual Pria Wanita',
      'price': 'Rp 149.000',
      'store': 'Saba Footwear Official Store',
      'sold': 'Terjual 2rb+',
      'imageUrl':
          'https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full/catalog-image/106/MTA-165796260/br-m036969-16325_saba-veron-low-ice-black-sepatu-sneakers-casual-pria-wanita_full10-1d42c59f.jpg',
    },
    {
      'name':
          'TOMKINS Necropolis - Hitam Sepatu Anak Remaja Sneakers Olahraga Kasual',
      'price': 'Rp 229.000',
      'store': 'TOMKINS Official Store',
      'sold': 'Terjual 1rb+',
      'imageUrl':
          'https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//102/MTA-85475045/tomkins_tomkins_necropolis_-_hitam_sepatu_anak_remaja_sneakers_olahraga_kasual_full01_ni8glvb.jpg',
    },
    {
      'name':
          'TOMKINS Banshee - Hitam Putih Sepatu Pria Sneakers Olahraga Kasual',
      'price': 'Rp 229.000',
      'store': 'TOMMINS Official Store',
      'sold': 'Terjual 1rb+',
      'imageUrl':
          'https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//105/MTA-79382157/tomkins_tomkins_banshee_-_hitam_putih_sepatu_pria_sneakers_olahraga_kasual_full01_m9wfwxgl.jpg',
    },
    // Add more products as needed
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 8), (timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _navigateToSearchPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchPage()),
    );
  }

  void _navigateToSaldoPage(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => SaldoPage(),
        transitionDuration: Duration.zero, // Tanpa animasi masuk
      ),
    );
  }

  void _navigateToMembershipPage(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            MembershipPage(),
        transitionDuration: Duration.zero, // Tanpa animasi masuk
      ),
    );
  }

  void _navigateToSubsPage(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => SubsPage(),
        transitionDuration: Duration.zero, // Tanpa animasi masuk
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _buildHorizontalMenuItem(IconData icon, String text, String subText,
      Function(BuildContext) onTap) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Row(
          children: [
            Icon(icon, size: 24.0),
            SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                Text(
                  subText,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(fontSize: 10.0, color: Colors.green),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerImage(int index) {
    List<String> imageUrls = [
      'https://images.tokopedia.net/img/cache/500/VxWOnu/2024/6/27/5e706bf8-0769-47df-b74e-65ae5a2f4d96.jpg',
      'https://images.tokopedia.net/img/cache/500/VxWOnu/2024/7/3/8f2d6c3f-6f2b-4f86-ad28-73701d3e4955.jpg',
      'https://images.tokopedia.net/img/cache/500/VxWOnu/2024/7/5/ba767055-4cff-417c-811b-cf205fb681fb.jpg',
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0), // Margin kiri dan kanan
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0), // Radius border untuk banner
        image: DecorationImage(
          image: NetworkImage(imageUrls[index]),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildSmallImage(String imageUrl, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap, // Panggil fungsi onTap yang diberikan saat gambar diklik
        child: Container(
          height: 60.0,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(8.0), // Radius border untuk gambar kecil
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, String> product) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)),
            child: Image.network(
              product['imageUrl']!,
              height: 150.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name']!,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  product['price']!,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.green,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  product['store']!,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 10.0,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Text(
                  product['sold']!,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 10.0,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          height: 40.0,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 40.0,
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.search, color: Colors.grey),
                    onPressed: () {
                      _navigateToSearchPage(context);
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    onSubmitted: (value) {
                      _navigateToSearchPage(context);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.email_outlined, color: Colors.grey),
            onPressed: () {
              // Action when email icon is pressed
            },
          ),
          IconButton(
            icon: Icon(Icons.menu, color: Colors.grey),
            onPressed: () {
              // Action when menu icon is pressed
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildHorizontalMenuItem(
                      Icons.account_balance_wallet_outlined,
                      'Saldo',
                      'Lihat saldo',
                      _navigateToSaldoPage),
                  _buildHorizontalMenuItem(
                      Icons.card_membership_outlined,
                      'Membership',
                      'Info keanggotaan',
                      _navigateToMembershipPage),
                  _buildHorizontalMenuItem(Icons.subscriptions_outlined,
                      'Langganan', 'Info langganan', _navigateToSubsPage),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(
              height: 130.0,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0), // Margin kiri kanan untuk banner
                    child: _buildBannerImage(index),
                  );
                },
                itemCount: 3, // Number of banners
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildSmallImage(
                        'https://www.static-src.com/siva/asset/06_2024/DBE-Desktop-Bliblimart_v2.png?w=294',
                        () {
                          // Navigasi ke halaman tertentu ketika gambar pertama diklik
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      HalamanPertama(),
                              transitionDuration:
                                  Duration.zero, // Tanpa animasi masuk
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 8.0),
                      _buildSmallImage(
                        'https://www.static-src.com/siva/asset/06_2024/DBE-Desktop-Gadget-Elektronik_v2.png?w=294',
                        () {
                          // Navigasi ke halaman lain ketika gambar kedua diklik
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      HalamanKedua(),
                              transitionDuration:
                                  Duration.zero, // Tanpa animasi masuk
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      _buildSmallImage(
                        'https://www.static-src.com/siva/asset/06_2024/DBE-Desktop-Fashion-Beauty_v2.png?w=294',
                        () {
                          // Navigasi ke halaman ketiga ketika gambar ketiga diklik
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      HalamanKetiga(),
                              transitionDuration:
                                  Duration.zero, // Tanpa animasi masuk
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 8.0),
                      _buildSmallImage(
                        'https://www.static-src.com/siva/asset/06_2024/DBE-Desktop-Tiket_v2.png?w=294',
                        () {
                          // Navigasi ke halaman keempat ketika gambar keempat diklik
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      HalamanKeempat(),
                              transitionDuration:
                                  Duration.zero, // Tanpa animasi masuk
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                      height:
                          10.0), // SizedBox untuk jarak antara gambar kecil dan teks produk terbaru
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Produk Terbaru',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      Text(
                        'Temukan Produk Terbaru',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 10.0,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: 10.0), // Space between text and product cards
                  GridView.builder(
                    physics:
                        NeverScrollableScrollPhysics(), // Disable GridView's scrolling
                    shrinkWrap: true, // Take up only the required space
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return _buildProductCard(products[index]);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
