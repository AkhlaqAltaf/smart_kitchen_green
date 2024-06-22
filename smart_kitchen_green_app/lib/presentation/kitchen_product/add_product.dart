import 'package:flutter/material.dart';
import 'package:smart_kitchen_green_app/data_layer/kitchen/kitchen_product.dart';
import 'package:smart_kitchen_green_app/presentation/kitchen_product/barcode_scanner.dart';
import 'package:smart_kitchen_green_app/presentation/kitchen_product/manually.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> with WidgetsBindingObserver {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _widgetOptions = [
      _buildManualEntry(),
      _buildScanner(),
      _buildVoiceEntry(),
    ];
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildManualEntry() {
    return AddManually();
  }

  Widget _buildScanner() {
    return BarcodeScannerPage();
  }

  void _saveScannedProduct(String scannedData) async {
    Product product = Product(
      name: 'Scanned Product',
      quantity: '1',
      expiryDate: '2024-12-31',
    );
    // Insert the product into the database here
    // Show snackbar only once per scan
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Product added to database')),
    );
  }

  Widget _buildVoiceEntry() {
    return Center(child: Text("It Is In Developement Process"));
  }

  List<Widget> _widgetOptions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Manual',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mic),
            label: 'Voice',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}
