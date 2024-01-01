import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:recipe_app/pages/register.page.dart';
import 'package:recipe_app/utlis/images.utlis.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var sliderIndex = 0;
  var currentindex = 0;
  CarouselController CarouselControllerEx = CarouselController();
  @override
  Widget build(BuildContext context) {
    var isFavorite = false;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.notes)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_outlined,
                        size: 25,
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "  Bonjour, $finalName",
                    style: TextStyle(
                        color: Color(0XFFB2B7C6),
                        fontFamily: 'Hellix',
                        fontSize: 12),
                  ),
                  SizedBox(),
                  Text(
                    " What would you like to cook \n  today?",
                    style: TextStyle(fontFamily: "AbrilFatface", fontSize: 20),
                  ),
                  SizedBox(),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              height: 30,
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: Color(0xFFF7F8FC),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(15),
                                  prefixIcon: Icon(
                                    Icons.search_outlined,
                                    color: Color(0xFFB2B7C6),
                                  ),
                                  hintText: "Search for recipes",
                                  hintStyle: TextStyle(
                                      fontSize: 12, color: Color(0xFFB2B7C6)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF7F8FC),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: IconButton(
                                icon: Icon(Icons.filter_list),
                                onPressed: () {}),
                          )
                        ],
                      )),
                  SizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Today Fresh Recipes',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(),
                      Text(
                        'See All',
                        style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'Hellix',
                            fontSize: 14),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CarouselSlider(
                  carouselController: CarouselControllerEx,
                  options: CarouselOptions(
                      height: 250.0,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 2),
                      viewportFraction: .75,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      enlargeCenterPage: true,
                      enlargeFactor: .3,
                      onPageChanged: (index, _) {
                        setState(() {});
                        sliderIndex = index;
                      }),
                  items: [1, 2, 3].map((i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: 180,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          height: 600,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xFFF7F8FC)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border, // Toggle icons
                                    color: isFavorite
                                        ? Colors.red
                                        : null, // Set color for filled state
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isFavorite =
                                          !isFavorite; // Toggle state on click
                                    });
                                  },
                                ),
                                Expanded(
                                  child: Image.asset("images/pic(${i}).png",
                                      fit: BoxFit.cover),
                                ),
                                SizedBox(),
                                Text(
                                  "Breakfast",
                                  style: TextStyle(
                                      fontFamily: "Hellix",
                                      fontSize: 10,
                                      color: Color(0xFF128FAE)),
                                ),
                                Text(
                                  "${Recipe.ImageName[i - 1]}",
                                  style: TextStyle(
                                      fontFamily: "Hellix", fontSize: 14),
                                ),
                                RatingBar.builder(
                                  itemSize: 15,
                                  initialRating: Recipe.RatingNum[i -
                                      1], // Initial rating (can be fractional)
                                  minRating: 1, // Minimum allowed rating
                                  direction: Axis
                                      .horizontal, // Direction of the rating bar
                                  allowHalfRating: true, // Allow half ratings
                                  itemCount: 5, // Number of stars
                                  itemBuilder: (context, _) => Icon(
                                      Icons.star_rounded,
                                      color: Color(
                                          0xFFF55A00)), // Star widget builder
                                  onRatingUpdate: (rating) {
                                    // Handle rating updates here
                                    print("New rating: $rating");
                                  },
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "${Recipe.Calorirs[i - 1]} Calories",
                                  style: TextStyle(
                                      fontFamily: "Hellix",
                                      fontSize: 8,
                                      color: Color(0xFFF55A00),
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(children: [
                                  Icon(
                                    Icons.access_time_outlined,
                                    color: Color(0xFFB2B7C6),
                                    size: 15,
                                  ),
                                  Text(
                                    " ${Recipe.Times[i - 1]} mins",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: "Hellix",
                                        color: Color(0xFFB2B7C6)),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.room_service_outlined,
                                    color: Color(0xFFB2B7C6),
                                    size: 15,
                                  ),
                                  Text(" 1 Serving",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: "Hellix",
                                          color: Color(0xFFB2B7C6)))
                                ])
                              ],
                            ),
                          )),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          CarouselControllerEx.previousPage();
                          setState(() {});
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                      IconButton(
                        onPressed: () {
                          CarouselControllerEx.nextPage();
                          setState(() {});
                        },
                        icon: Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(),
            DotsIndicator(
              dotsCount: 3,
              position: sliderIndex.toDouble(),
              onTap: (postion) async {
                await CarouselControllerEx.animateToPage(postion.toInt());
                sliderIndex = postion.toInt();
                currentindex = sliderIndex;
                setState(() {});
              },
              decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  activeColor: Colors.black54),
            ),
            SizedBox(
              height: 2,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: 3,
                itemBuilder: (context, index) => Container(
                    width: 180,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    height: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFFF7F8FC)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Image.asset("images/pic(${index + 3}).png",
                                fit: BoxFit.cover),
                          ),
                          SizedBox(),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(),
                                Text(
                                  "${Recipe.DishName[index]}",
                                  style: TextStyle(
                                      fontFamily: "Hellix",
                                      fontSize: 10,
                                      color: Color(0xFF128FAE)),
                                ),
                                SizedBox(),
                                Text(
                                  "${Recipe.ImageName[index + 2]}",
                                  style: TextStyle(
                                      fontFamily: "Hellix", fontSize: 14),
                                ),
                                RatingBar.builder(
                                  itemSize: 15,
                                  initialRating: Recipe.RatingNum[
                                      index], // Initial rating (can be fractional)
                                  minRating: 1, // Minimum allowed rating
                                  direction: Axis
                                      .horizontal, // Direction of the rating bar
                                  allowHalfRating: true, // Allow half ratings
                                  itemCount: 5, // Number of stars
                                  itemBuilder: (context, _) => Icon(
                                      Icons.star_rounded,
                                      color: Color(
                                          0xFFF55A00)), // Star widget builder
                                  onRatingUpdate: (rating) {
                                    // Handle rating updates here
                                    print("New rating: $rating");
                                  },
                                ),
                                SizedBox(),
                                Text(
                                  "${Recipe.Calorirs[index + 2]} Calories",
                                  style: TextStyle(
                                      fontFamily: "Hellix",
                                      fontSize: 8,
                                      color: Color(0xFFF55A00),
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Row(children: [
                                  Icon(
                                    Icons.access_time_outlined,
                                    color: Color(0xFFB2B7C6),
                                    size: 15,
                                  ),
                                  Text(
                                    " ${Recipe.Times[index + 2]} mins",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: "Hellix",
                                        color: Color(0xFFB2B7C6)),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.room_service_outlined,
                                    color: Color(0xFFB2B7C6),
                                    size: 15,
                                  ),
                                  Text(" 1 Serving",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: "Hellix",
                                          color: Color(0xFFB2B7C6)))
                                ])
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border, // Toggle icons
                              color: isFavorite
                                  ? Colors.red
                                  : null, // Set color for filled state
                            ),
                            onPressed: () {
                              setState(() {
                                isFavorite =
                                    !isFavorite; // Toggle state on click
                              });
                            },
                          ),
                        ],
                      ),
                    )),
                separatorBuilder: (context, index) =>
                    Divider(), // Use a default divider
              ),
            )
          ],
        ),
      ),
    );
  }
}
