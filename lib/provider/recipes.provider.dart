import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/recipe.models.dart';

class RecipeProvider extends ChangeNotifier {
  List<Recipes> _recipes = [];

  List<Recipes> get recipes => _recipes;

  Future<List<Recipes>> getRecipes() async {
    var recipesData = await rootBundle.loadString('assets/data/sample.json');

    var dataDecoded =
        List<Map<String, dynamic>>.from(jsonDecode(recipesData)['recipes']);
    notifyListeners();
    return dataDecoded.map((e) => Recipes.fromJson(e)).toList();
  }
}
