import 'dart:convert';

import 'package:smart_kitchen_green_app/apis/urls/urls.dart';
import 'package:smart_kitchen_green_app/data_layer/plants/plant.dart';
import 'package:http/http.dart' as http;
import 'package:smart_kitchen_green_app/storage/auth_storage.dart';
import 'package:smart_kitchen_green_app/widgets/flashMessage.dart';

Future<List<Plant>> fetchRecomendations(context, latitude, longitude) async {
  String? token = await getToken();

  try {
    var response = await http.get(
      Uri.parse("${Urls.recommended_plants + latitude + "/" + longitude}"),
      headers: {
        'Authorization': 'TOKEN $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode < 300) {
      List<Plant> plants = [];
      Iterable jsonResponse = json.decode(response.body);
      jsonResponse.forEach((element) {
        Plant product = Plant.fromJson(element);
        plants.add(product);
      });

      return plants;
    } else {
      flashMessage(context, 'error', response.body);
      return [];
    }
  } catch (e) {
    return [];
  }
}
