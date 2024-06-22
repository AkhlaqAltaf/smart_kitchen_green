import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:convert';

import 'package:smart_kitchen_green_app/apis/kitchen_apis/barcode_info.dart';

class BarcodeScannerScreen extends StatefulWidget {
  @override
  _BarcodeScannerScreenState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  bool isScanned = false;
  String? lastScannedCode;
  String productName = '';
  String productPrice = '';
  String productExpiry = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: MobileScanner(onDetect: (barcode) async {
              if (!isScanned) {
                final String code = barcode.barcodes.first.rawValue ?? "---";
                print(code);
                setState(() {
                  isScanned = true;
                  lastScannedCode = code;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Scanned: $code'),
                    duration: Duration(seconds: 10),
                  ),
                );
                // Fetch product details
                final productDetails = await fetchProductDetails(code);
                if (productDetails != null) {
                  setState(() {
                    productName = productDetails['product_name'] ?? 'Unknown';
                    productPrice = productDetails['price'] ?? 'Unknown';
                    productExpiry =
                        productDetails['expiration_date'] ?? 'Unknown';
                  });
                } else {
                  setState(() {
                    productName = 'Product not found';
                    productPrice = 'N/A';
                    productExpiry = 'N/A';
                  });
                }

                Future.delayed(Duration(seconds: 2), () {
                  setState(() {
                    isScanned = false; // Reset the flag after a delay
                  });
                });
              }
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Product Name: $productName'),
                Text('Product Price: $productPrice'),
                Text('Expiry Date: $productExpiry'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
