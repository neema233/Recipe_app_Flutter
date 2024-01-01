abstract class ImagesPath {
  static const String _Path = 'images/';
  static String backgroundimage = '${_Path}Mask Group 9.png';
  static String logoimage = '${_Path}Logo (1).png';
}

abstract class Recipe {
  static List ImageName = [
    "French Toast with Berries",
    "Cinnamon Toast",
    "Blueberry Muffiens",
    "Glazed Salmon",
    "Asian Glazed Chicken Thighs"
  ];
  static List RatingNum = [5, 4, 3, 5, 5];
  static List Calorirs = [120, 135, 120, 280, 200];
  static List Times = [10, 15, 20, 45, 30];
  static List DishName = ["Breakfast", "Main Dish", "Dinner"];
}
