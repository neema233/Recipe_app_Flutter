import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../models/recipe.models.dart';

part 'recipes_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  RecipeCubit() : super(RecipeInitial());

  getRecipes() async {
    print("Getting recipes");
    emit(RecipeLoading());

    try {
      var recipes = await _loadRecipes();

      print("Recipes loaded: $recipes");

      emit(RecipeLoaded(recipes));
    } catch (e) {
      print("Error getting recipes: $e");
      emit(RecipeError(e.toString()));
    }
  }

  Future<List<Recipes>> _loadRecipes() async {
    var recipesData = await rootBundle.loadString('assets/data/sample.json');

    var dataDecoded =
        List<Map<String, dynamic>>.from(jsonDecode(recipesData)['recipes']);

    return dataDecoded.map((e) => Recipes.fromJson(e)).toList();
  }
}
