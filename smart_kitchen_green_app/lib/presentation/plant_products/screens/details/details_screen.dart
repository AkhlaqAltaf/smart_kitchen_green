import 'package:flutter/material.dart';
import 'package:smart_kitchen_green_app/presentation/plant_products/screens/details/components/body.dart';
import 'package:smart_kitchen_green_app/widgets/custom_appbar.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(""),
      body: Body(),
    );
  }
}
