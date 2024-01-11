class FoodImage {
  String? name;
  String? imageUrl;

  FoodImage({this.name, this.imageUrl});

  factory FoodImage.fromJson(Map<String, dynamic> json) {
    return FoodImage(
      name: json['name'],
      imageUrl: json['image'],
    );
  }
}
