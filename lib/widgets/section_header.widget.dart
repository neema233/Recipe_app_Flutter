import 'package:flutter/material.dart';
import 'package:recipe_app/utlis/colors_and_text.utlis.dart';

class SectionHeader extends StatefulWidget {
  final String sectionName;
  const SectionHeader({required this.sectionName, super.key});

  @override
  State<SectionHeader> createState() => _SectionHeaderState();
}

class _SectionHeaderState extends State<SectionHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.sectionName,
          style: StyleCons.sectionText,
        ),
        TextButton(
            onPressed: () {},
            child: const Text("See All", style: StyleCons.choicesText))
      ],
    );
  }
}
