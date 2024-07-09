import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:updateapkv2/Page/Home/Menu/CartModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:updateapkv2/Page/Home/Menu/CheckOutPage/CheckOutPage.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: cart.cartItems.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.network(
                      'https://www.static-src.com/frontend/retail/static/img/empty-bag.97af327c.svg',
                      width: 150,
                      height: 150,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Bag Kamu Masih Kosong',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Yuk, temukan produk terbaikmu \n dan tambahkan ke bag.',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : Consumer<CartModel>(
                  builder: (context, cart, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: cart.cartItems.length,
                            itemBuilder: (context, index) {
                              final item = cart.cartItems[index];
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey.shade300),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          item['imageUrl'] ?? '',
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(width: 16.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item['store'] ?? '',
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 4.0),
                                              Text(
                                                item['name'] ?? '',
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 4.0),
                                              Row(
                                                children: [
                                                  Text(
                                                    '${item['price'] ?? ''}',
                                                    style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                        fontSize: 12.0,
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
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.delete_forever_outlined,
                                          color: Colors.grey,
                                          size: 18,
                                        ),
                                        onPressed: () {
                                          // Handle item removal
                                          cart.removeFromCart(index);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (cart.cartItems.isNotEmpty) {
                                // Navigate to checkout page with all cart items
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => CheckoutPage(
                                      products: cart.cartItems,
                                      quantity: '1', // Update this with actual quantity if available
                                    ),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 32.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                            child: Text(
                              'Beli Sekarang',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
        ),
      ),
    );
  }
}
