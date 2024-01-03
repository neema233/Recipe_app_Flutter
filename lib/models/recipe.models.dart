// ignore_for_file: non_constant_identifier_names, avoid_web_libraries_in_flutter

class Recipes {
  int? id;
  String? meal_type;
  String? title;
  String? description;
  String? image;
  double? rating;
  int? calories;
  int? prep_time;
  int? serving;

  Recipes();

  Recipes.fromJson(Map<String, dynamic> data) {
    id = data["id"];
    meal_type = data["meal_type"];
    title = data["title"];
    description = data["description"];
    image = data["image"];
    rating = data["rating"];
    calories = data["calories"];
    prep_time = data["prep_time"];
    serving = data["serving"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "meal_type": meal_type,
      "title": title,
      "escription": description,
      "image": image,
      "rating": rating,
      "calories": calories,
      "prep_time": prep_time,
      "serving": serving
    };
  }
}
