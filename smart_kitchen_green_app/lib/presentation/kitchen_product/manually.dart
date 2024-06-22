import 'package:flutter/material.dart';

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
            decoration: InputDecoration(labelText: 'Product Name'),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Quantity',
                hintText: "2",
                prefixIcon: Icon(Icons.numbers)),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Expiry Date'),
          ),
          SizedBox(
            height: 30,
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
    ));
  }
}
