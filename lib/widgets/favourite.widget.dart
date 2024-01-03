import 'package:flutter/material.dart';
import 'package:recipe_app/utlis/colors_and_text.utlis.dart';

// ignore: must_be_immutable
class FavoriteIconButton extends StatefulWidget {
  bool isFavorite;

  FavoriteIconButton({
    super.key,
    required this.isFavorite,
  });

  @override
  State<FavoriteIconButton> createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        widget.isFavorite ? Icons.favorite : Icons.favorite_border,
        color: widget.isFavorite ? const Color(ColorsConst.mainColor) : null,
      ),
      onPressed: () {
        setState(() {
          widget.isFavorite = !widget.isFavorite;
        });
      },
    );
  }
}
