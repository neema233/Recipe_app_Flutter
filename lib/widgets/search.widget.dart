import 'package:flutter/material.dart';
import '../utlis/colors_and_text.utlis.dart';

class Search extends StatelessWidget {
  const Search({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Container(
            height: 30,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: const Color(ColorsConst.fillColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(15),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(ColorsConst.containerBackgroundColor),
                ),
                hintText: "Search for recipes",
                hintStyle: StyleCons.searchText,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          height: 30,
          decoration: BoxDecoration(
            color: const Color(ColorsConst.fillColor),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Expanded(
            child: IconButton(
                icon: const Icon(
                  Icons.tune_rounded,
                  size: 21,
                ),
                onPressed: () {}),
          ),
        )
      ],
    );
  }
}
