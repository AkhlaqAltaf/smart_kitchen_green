import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:smart_kitchen_green_app/data_layer/kitchen/kitchen_product.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> with WidgetsBindingObserver {
  final MobileScannerController _controller = MobileScannerController();
  int _selectedIndex = 0;
  String? lastScannedCode;
  bool isScanning = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller.barcodes.listen((event) {
      if (event.barcodes.isNotEmpty) {
        final barcode = event.barcodes.first;
        print(",.................................${event.raw}");
        if (barcode.rawValue != null) {
          final String code = barcode.rawValue!;
          if (isScanning &&
              (lastScannedCode == null || lastScannedCode != code)) {
            setState(() {
              lastScannedCode = code;
              isScanning = false;
            });
            _saveScannedProduct(code);
            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                isScanning = true;
              });
            });
          }
        }
      }
    });
    _widgetOptions = [
      _buildManualEntry(),
      _buildScanner(),
      _buildVoiceEntry(),
    ];
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildManualEntry() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Product Name'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Quantity'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Expiry Date'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle the form submission here
            },
            child: Text('Add Product'),
          ),
        ],
      ),
    );
  }

  Widget _buildScanner() {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: MobileScanner(
            controller: _controller,
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text('Scan result: $lastScannedCode'),
          ),
        ),
      ],
    );
  }

  void _saveScannedProduct(String scannedData) async {
    // Simulating the extraction of product details from scanned data
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
    return Center(
      child: Text(
        'It is in development process',
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
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
