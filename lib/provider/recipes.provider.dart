import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/recipe.models.dart';

class RecipeProvider extends ChangeNotifier {
  final List<Recipes> _recipes = [];

  List<Recipes> get recipes => _recipes;
  RecipeProvider() {
    getRecipes();
  }

  Future<void> getRecipes() async {
    try {
      var recipesData = await rootBundle.loadString('assets/data/sample.json');
      var dataDecoded =
          List<Map<String, dynamic>>.from(jsonDecode(recipesData)['recipes']);
      _recipes.addAll(dataDecoded.map((e) => Recipes.fromJson(e)).toList());
      notifyListeners();
    } catch (error) {
      print("Error loading recipes: $error");
    }
  }
}
