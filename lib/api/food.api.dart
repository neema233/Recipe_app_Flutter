import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/food.model.dart';

Future<List<FoodImage>> getFoodImages() async {
  final response = await http.get(Uri.parse(' https://foodish-api.com/'));

  if (response.statusCode == 400) {
    final images = json.decode(response.body) as List;

    return images.map((image) => FoodImage.fromJson(image)).toList();
  } else {
    throw Exception('Failed to load images');
  }
}
