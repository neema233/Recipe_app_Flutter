import 'dart:convert';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe_app/utlis/colors_and_text.utlis.dart';
import 'package:recipe_app/utlis/numbers.utlis.dart';
import 'package:recipe_app/widgets/favourite.widget.dart';
import 'package:recipe_app/widgets/section_header.widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/ad.models.dart';
import 'package:recipe_app/models/recipe.models.dart';
import '../widgets/ratingbar.widget.dart';
import '../widgets/search.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var sliderIndex = 0;
  var currentindex = 0;
  CarouselController carouselControllerEx = CarouselController();

  List<Ad> adsList = [];

  void getAds() async {
    var adsData = await rootBundle.loadString('assets/data/sample.json');
    var dataDecoded =
        List<Map<String, dynamic>>.from(jsonDecode(adsData)['ads']);
    adsList = dataDecoded.map((e) => Ad.fromJson(e)).toList();
    setState(() {});
  }

  List<Recipes> recipeList = [];

  void getRecipe() async {
    var recipesData = await rootBundle.loadString('assets/data/sample.json');
    var data2Decoded =
        List<Map<String, dynamic>>.from(jsonDecode(recipesData)['recipes']);
    recipeList = data2Decoded.map((e) => Recipes.fromJson(e)).toList();
    setState(() {});
  }

  @override
  void initState() {
    getAds();
    getRecipe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isFavorite = false;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //list bar
            Padding(
              padding: const EdgeInsets.fromLTRB(Numbers.appHorizontalPadding,
                  Numbers.appVerticalPadding, Numbers.appHorizontalPadding, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.notes_rounded)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_outlined,
                        size: 25,
                      ))
                ],
              ),
            ),
            // Greating user,Intro,Section1
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Bonjour, ${GetIt.I.get<SharedPreferences>().getString('FullName')}",
                        style: const TextStyle(
                            color: Color(ColorsConst.containerBackgroundColor),
                            fontFamily: 'Hellix',
                            fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "What would you like to cook \ntoday?",
                        style: StyleCons.introText,
                      ),
                    ],
                  ),
                  const SizedBox(),
                  const Search(),
                  const SizedBox(),
                  const SectionHeader(sectionName: "Today Fresh Recipes")
                ],
              ),
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                recipeList.isEmpty
                    ? const CircularProgressIndicator(
                        color: Color(ColorsConst.mainColor),
                        strokeWidth: 2,
                      )
                    : CarouselSlider(
                        carouselController: carouselControllerEx,
                        options: CarouselOptions(
                            height: 250.0,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            viewportFraction: .75,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                            enlargeCenterPage: true,
                            enlargeFactor: .3,
                            onPageChanged: (index, _) {
                              setState(() {});
                              sliderIndex = index;
                              print(recipeList);
                            }),
                        items: recipeList.map((Recipes recipe) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: 180,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                height: 600,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color(0xFFF7F8FC)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FavoriteIconButton(
                                          isFavorite: isFavorite),
                                      Expanded(
                                        child: Image.asset(recipe.image!,
                                            fit: BoxFit.cover),
                                      ),
                                      const SizedBox(),
                                      Text(
                                        "${recipe.meal_type}",
                                        style: StyleCons.dishTypeText,
                                      ),
                                      Text(
                                        "${recipe.title}",
                                        style: StyleCons.dishNameText,
                                      ),
                                      RatingBars(initrate: recipe.rating!),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        "${recipe.calories} Calories",
                                        style: StyleCons.caloriesText,
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Row(children: [
                                        const Icon(
                                          Icons.access_time_outlined,
                                          color: Color(ColorsConst
                                              .containerBackgroundColor),
                                          size: 15,
                                        ),
                                        Text(
                                          " ${recipe.prep_time} mins",
                                          style: StyleCons.serviceText,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Icon(
                                          Icons.room_service_outlined,
                                          color: Color(ColorsConst
                                              .containerBackgroundColor),
                                          size: 15,
                                        ),
                                        Text("${recipe.serving} Serving",
                                            style: StyleCons.serviceText)
                                      ])
                                    ],
                                  ),
                                )),
                          );
                        }).toList(),
                      ),
                Padding(
                  padding: const EdgeInsets.all(Numbers.appVerticalPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          carouselControllerEx.previousPage();
                          setState(() {});
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      IconButton(
                        onPressed: () {
                          carouselControllerEx.nextPage();
                          setState(() {});
                        },
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(),
            DotsIndicator(
              dotsCount: recipeList.length,
              position: sliderIndex.toDouble(),
              onTap: (postion) async {
                await carouselControllerEx.animateToPage(postion.toInt());
                sliderIndex = postion.toInt();
                currentindex = sliderIndex;
                setState(() {});
              },
              decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  activeColor: const Color(ColorsConst.mainColor)),
            ),
            const SizedBox(
              height: 2,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: recipeList.length,
                itemBuilder: (context, index) {
                  final recipecard = recipeList[index];
                  return Padding(
                    padding: const EdgeInsets.all(Numbers.appHorizontalPadding),
                    child: Container(
                        width: 180,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        height: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(ColorsConst.fillColor)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Image.asset("${recipecard.image}",
                                  fit: BoxFit.cover),
                            ),
                            const SizedBox(),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(),
                                  Text(
                                    "${recipecard.meal_type}",
                                    style: StyleCons.dishTypeText,
                                  ),
                                  const SizedBox(),
                                  Text(
                                    "${recipecard.title}",
                                    style: StyleCons.dishNameText,
                                  ),
                                  RatingBars(initrate: index.toDouble()),
                                  const SizedBox(),
                                  Text(
                                    "${recipecard.calories} Calories",
                                    style: StyleCons.caloriesText,
                                  ),
                                  const Spacer(),
                                  Row(children: [
                                    const Icon(
                                      Icons.access_time_outlined,
                                      color: Color(
                                          ColorsConst.containerBackgroundColor),
                                      size: 15,
                                    ),
                                    Text(
                                      " ${recipecard.prep_time} mins",
                                      style: StyleCons.serviceText,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(
                                      Icons.room_service_outlined,
                                      color: Color(
                                          ColorsConst.containerBackgroundColor),
                                      size: 15,
                                    ),
                                    Text("${recipecard.serving} Serving",
                                        style: StyleCons.serviceText)
                                  ])
                                ],
                              ),
                            ),
                            FavoriteIconButton(isFavorite: isFavorite),
                          ],
                        )),
                  );
                },
                separatorBuilder: (context, index) =>
                    const Divider(), // Use a default divider
              ),
            )
          ],
        ),
      ),
    );
  }
}
