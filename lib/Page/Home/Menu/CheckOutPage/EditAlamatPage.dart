import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditAddressScreen extends StatefulWidget {
  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  String selectedMenu = 'Semua Alamat'; // Default selected menu
  List<Map<String, String>> addresses = []; // List to store addresses
  Map<String, String>? selectedAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Daftar Alamat',
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
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 12.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari Alamat',
                      hintStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(fontSize: 14.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedMenu = 'Semua Alamat';
                          });
                        },
                        child: buildMenu('Semua Alamat', selectedMenu == 'Semua Alamat'),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedMenu = 'Tambahkan Alamat';
                          });
                        },
                        child: buildMenu('Tambahkan Alamat', selectedMenu == 'Tambahkan Alamat'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    if (selectedMenu == 'Semua Alamat')
                      addresses.isEmpty
                          ? Column(
                              children: [
                                Image.network(
                                  'https://www.static-src.com/frontend/notification/static/1.3.0-1/desktop/img/empty-notification.ef9b18ec.png',
                                  height: 200,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Belum ada alamat yang ditambahkan',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Expanded(
                              child: ListView(
                                children: addresses.map((address) => buildAddressCard(address)).toList(),
                              ),
                            ),
                    if (selectedMenu == 'Tambahkan Alamat') buildAddAddressForm(),
                  ],
                ),
              ),
            ),
            if (selectedMenu == 'Tambahkan Alamat')
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_validateAddressForm()) {
                        // Save address to the list
                        setState(() {
                          addresses.add({
                            'buildingType': buildingTypeController.text,
                            'username': usernameController.text,
                            'phone': phoneController.text,
                            'address': addressController.text,
                          });
                          // Clear input fields
                          buildingTypeController.clear();
                          usernameController.clear();
                          phoneController.clear();
                          addressController.clear();
                          // Switch back to "Semua Alamat" menu
                          selectedMenu = 'Semua Alamat';
                        });
                      }
                    },
                    child: Text(
                      'Simpan Alamat',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      minimumSize: Size(double.infinity, 50), // Full width button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4), // Rectangular button shape
                      ),
                    ),
                  ),
                ),
              ),
            if (selectedMenu == 'Semua Alamat')
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: selectedAddress == null
                        ? null
                        : () {
                            // Handle using selected address
                            print('Using address: $selectedAddress');
                          },
                    child: Text(
                      'Gunakan Alamat',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          selectedAddress == null ? Colors.grey : Colors.blue,
                      minimumSize: Size(double.infinity, 50), // Full width button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4), // Rectangular button shape
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

  // Method to build menu items
  Widget buildMenu(String title, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2.0,
          ),
        ),
      ),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: 14.0,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.blue : Colors.black,
          ),
        ),
      ),
    );
  }

  // Method to build address card widget
  Widget buildAddressCard(Map<String, String> address) {
    bool isSelected = selectedAddress == address;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAddress = isSelected ? null : address;
        });
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: isSelected ? Colors.blue : Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                address['buildingType']!,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                address['username']!,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 4),
              Text(
                address['phone']!,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 4),
              Text(
                address['address']!,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to edit address screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddAddressScreen(
                            initialAddress: address,
                            onUpdateAddress: (updatedAddress) {
                              // Update address in the list
                              setState(() {
                                int index = addresses.indexOf(address);
                                addresses[index] = updatedAddress;
                              });
                            },
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Ubah Alamat',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      minimumSize: Size(120, 40), // Set minimum width and height
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4), // Rectangular button shape
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.blue),
                    onPressed: () {
                      // Show bottom sheet to confirm deletion
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.network(
                                  'https://www.static-src.com/frontend/notification/static/1.3.0-1/desktop/img/empty-notification.ef9b18ec.png',
                                  height: 200,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Hapus Alamat',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Apakah Kamu yakin ingin menghapus alamat ini?',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    // Remove address from the list
                                    setState(() {
                                      addresses.remove(address);
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Hapus',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.blue,
                                    minimumSize: Size(double.infinity, 50), // Full width button
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4), // Rectangular button shape
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Batal',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Colors.blue),
                                    minimumSize: Size(double.infinity, 50), // Full width button
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4), // Rectangular button shape
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Controllers for form input fields
  final buildingTypeController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  // Method to build add address form
  Widget buildAddAddressForm() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildInputField(buildingTypeController, 'Tipe Bangunan', 'Cth: Rumah'),
            SizedBox(height: 16.0),
            buildInputField(usernameController, 'Nama Penerima', 'Cth: Budi Santoso'),
            SizedBox(height: 16.0),
            buildInputField(phoneController, 'Nomor Telepon', 'Cth: 081234567890'),
            SizedBox(height: 16.0),
            buildInputField(addressController, 'Alamat Lengkap', 'Cth: Jl. Merdeka No. 123'),
          ],
        ),
      ),
    );
  }

  // Method to build input fields
  Widget buildInputField(TextEditingController controller, String labelText, String hintText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      ),
    );
  }

  // Method to validate address form
  bool _validateAddressForm() {
    if (buildingTypeController.text.isEmpty ||
        usernameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressController.text.isEmpty) {
      return false;
    }
    return true;
  }
}

// Screen for adding/editing address
class AddAddressScreen extends StatefulWidget {
  final Map<String, String>? initialAddress;
  final Function(Map<String, String>) onUpdateAddress;

  AddAddressScreen({this.initialAddress, required this.onUpdateAddress});

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  late TextEditingController buildingTypeController;
  late TextEditingController usernameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with initial address if provided
    buildingTypeController = TextEditingController(text: widget.initialAddress?['buildingType'] ?? '');
    usernameController = TextEditingController(text: widget.initialAddress?['username'] ?? '');
    phoneController = TextEditingController(text: widget.initialAddress?['phone'] ?? '');
    addressController = TextEditingController(text: widget.initialAddress?['address'] ?? '');
  }

  @override
  void dispose() {
    // Dispose controllers to free resources
    buildingTypeController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  // Method to build input fields
  Widget buildInputField(TextEditingController controller, String labelText, String hintText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      ),
    );
  }

  // Method to validate address form
  bool _validateAddressForm() {
    if (buildingTypeController.text.isEmpty ||
        usernameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ubah Alamat',
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildInputField(buildingTypeController, 'Tipe Bangunan', 'Cth: Rumah'),
            SizedBox(height: 16.0),
            buildInputField(usernameController, 'Nama Penerima', 'Cth: Budi Santoso'),
            SizedBox(height: 16.0),
            buildInputField(phoneController, 'Nomor Telepon', 'Cth: 081234567890'),
            SizedBox(height: 16.0),
            buildInputField(addressController, 'Alamat Lengkap', 'Cth: Jl. Merdeka No. 123'),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                if (_validateAddressForm()) {
                  // Update address and navigate back
                  widget.onUpdateAddress({
                    'buildingType': buildingTypeController.text,
                    'username': usernameController.text,
                    'phone': phoneController.text,
                    'address': addressController.text,
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                'Simpan Alamat',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50), // Full width button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4), // Rectangular button shape
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
