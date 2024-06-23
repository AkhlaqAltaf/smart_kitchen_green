import 'package:flutter/material.dart';
import 'package:smart_kitchen_green_app/presentation/kitchen_product/product_list/temp_list_products.dart';

class AddManually extends StatefulWidget {
  const AddManually({super.key});

  @override
  State<AddManually> createState() => _AddManuallyState();
}

class _AddManuallyState extends State<AddManually> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Product Name', prefixIcon: Icon(Icons.text_fields)),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: 'Quantity', prefixIcon: Icon(Icons.numbers)),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
                hintText: "YYYY-MM-DD",
                labelText: 'Expiry Date',
                prefixIcon: Icon(Icons.date_range)),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: Text('Add Product'),
          ),
          TempListProducts(),
        ],
      ),
    ));
  }
}
