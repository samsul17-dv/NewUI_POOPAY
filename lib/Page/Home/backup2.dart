import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:updateapkv2/Page/Home/Menu/DetailProduk.dart';
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
  List<Map<String, String>> products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
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

  Future<void> _fetchProducts() async {
    final response =
        await http.get(Uri.parse('http://your-server-url/get_products.php'));

    if (response.statusCode == 200) {
      final List<dynamic> productJson = json.decode(response.body);
      setState(() {
        products =
            productJson.map((json) => Map<String, String>.from(json)).toList();
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  void _shuffleProducts() {
    setState(() {
      products.shuffle();
    });
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
        transitionDuration: Duration.zero, // No entrance animation
      ),
    );
  }

  void _navigateToMembershipPage(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            MembershipPage(),
        transitionDuration: Duration.zero, // No entrance animation
      ),
    );
  }

  void _navigateToSubsPage(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => SubsPage(),
        transitionDuration: Duration.zero, // No entrance animation
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
                    textStyle: TextStyle(fontSize: 10.0, color: Colors.blue),
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
      margin: EdgeInsets.symmetric(horizontal: 8.0), // Left and right margin
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0), // Border radius for banner
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
        onTap:
            onTap, // Call the provided onTap function when the image is clicked
        child: Container(
          height: 60.0,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(8.0), // Border radius for small image
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                DetailProductPage(product: product),
            transitionDuration: Duration.zero, // No entrance animation
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
              child: Image.network(
                product['imageUrl']!,
                height: 120.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name']!,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    product['price']!,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Text(
                    product['store']!,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                      ),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 10.0),
                      Text(
                        product['sold']!,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
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
  physics: AlwaysScrollableScrollPhysics(),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 20, right: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHorizontalMenuItem(
              Icons.account_balance_wallet_outlined,
              'Saldo',
              'Buka EPay',
              _navigateToSaldoPage,
            ),
            _buildHorizontalMenuItem(
              Icons.card_membership_outlined,
              'Diskon 80%',
              'Cuma 10rb/bln',
              _navigateToMembershipPage,
            ),
            _buildHorizontalMenuItem(
              Icons.subscriptions_outlined,
              'Silver',
              '0 Kupon Baru',
              _navigateToSubsPage,
            ),
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
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: _buildBannerImage(index),
                    );
                  },
                  itemCount: 3,
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
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        HalamanPertama(),
                                transitionDuration: Duration.zero,
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 8.0),
                        _buildSmallImage(
                          'https://www.static-src.com/siva/asset/06_2024/DBE-Desktop-Gadget-Elektronik_v2.png?w=294',
                          () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        HalamanKedua(),
                                transitionDuration: Duration.zero,
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
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        HalamanKetiga(),
                                transitionDuration: Duration.zero,
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 8.0),
                        _buildSmallImage(
                          'https://www.static-src.com/siva/asset/06_2024/DBE-Desktop-Tiket_v2.png?w=294',
                          () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        HalamanKeempat(),
                                transitionDuration: Duration.zero,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Semua Produk',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        Text(
                          'Dapatkan Produk Keinginan-Mu',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 10.0,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
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
    