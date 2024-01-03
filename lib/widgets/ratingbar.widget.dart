// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:recipe_app/utlis/colors_and_text.utlis.dart';

// ignore: must_be_immutable
class RatingBars extends StatefulWidget {
  double initrate;

  RatingBars({
    super.key,
    required this.initrate,
  });

  @override
  State<RatingBars> createState() => _RatingBarsState();
}

class _RatingBarsState extends State<RatingBars> {
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemSize: 15,
      initialRating: widget.initrate, // Initial rating (can be fractional)
      minRating: 1, // Minimum allowed rating
      direction: Axis.horizontal, // Direction of the rating bar
      allowHalfRating: true, // Allow half ratings
      itemCount: 5, // Number of stars
      itemBuilder: (context, _) => const Icon(Icons.star_rounded,
          color: Color(ColorsConst.mainColor)), // Star widget builder
      onRatingUpdate: (rating) {
        // Handle rating updates here
        print("New rating: $rating");
      },
    );
  }
}
