import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:updateapkv2/Page/Home/Menu/CartModel.dart';
import 'package:updateapkv2/Page/Home/Menu/CheckOutPage/CheckOutPage.dart';

class DetailProductPage extends StatefulWidget {
  final Map<String, String> product;

  const DetailProductPage({Key? key, required this.product}) : super(key: key);

  @override
  _DetailProductPageState createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  String? selectedOption;
  late int cartItemCount; // Declare cartItemCount

  @override
  void initState() {
    super.initState();
    cartItemCount = Provider.of<CartModel>(context, listen: false)
        .cartItems
        .length; // Access cartItems instead of cart
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              widget.product['imageUrl']!,
              height: 300.0,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product['price']!,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    widget.product['store']!,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Text(
                    widget.product['name']!,
                    maxLines: 2, // Batasi menjadi 2 baris
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Deskripsi Produk',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    widget.product['description'] ?? '',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.0),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  _showBuyNowPopup(context);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.blue),
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                child: Text(
                  'Beli Sekarang',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 12.0,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<CartModel>(context, listen: false)
                      .addToCart(widget.product);
                  _showCartNotification(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                child: Text(
                  'Masukkan Keranjang',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCartNotification(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 70.0),
          child: _buildCartContent(context),
        );
      },
    );
  }

  Widget _buildCartContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.network(
          'https://www.static-src.com/frontend/retail/static/img/empty-bag.97af327c.svg',
          height: 200,
          width: 200,
        ),
        SizedBox(height: 16.0),
        Text(
          'Produk di Masukkan ke Keranjang',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 14.0,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void _showBuyNowPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
              child: _buildBuyNowContent(context, setState),
            );
          },
        );
      },
    );
  }

  Widget _buildBuyNowContent(BuildContext context, StateSetter setState) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.network(
              widget.product['imageUrl']!,
              height: 120.0,
              width: 120.0,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product['name']!,
                    maxLines: 3, // Batasi menjadi 2 baris
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    widget.product['price']!,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'Pilih Jumlah :',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            Expanded(child: _buildOptionButton(context, setState, '1 PCS')),
            SizedBox(width: 8.0),
            Expanded(child: _buildOptionButton(context, setState, '2 PCS')),
            SizedBox(width: 8.0),
            Expanded(child: _buildOptionButton(context, setState, '3 PCS')),
          ],
        ),
        SizedBox(height: 16.0),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: selectedOption != null
                ? () {
                    // Handle Buy Now action with selectedOption
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CheckoutPage(
                          products: [widget.product], // Pass product as a list
                          quantity: selectedOption!,
                        ),
                      ),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  selectedOption != null ? Colors.blue : Colors.grey,
              padding: EdgeInsets.symmetric(vertical: 20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            child: Text(
              'Beli Sekarang',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionButton(
      BuildContext context, StateSetter setState, String option) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selectedOption = option;
        });
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: selectedOption == option ? Colors.blue : Colors.white,
        side: BorderSide(color: Colors.blue),
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      child: Text(
        option,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: 12.0,
            color: selectedOption == option ? Colors.white : Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
