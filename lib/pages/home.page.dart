import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:recipe_app/pages/register.page.dart';
import 'package:recipe_app/utlis/images.utlis.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello $finalName",
                      style: TextStyle(
                          color: Color(0XFFB2B7C6),
                          fontFamily: 'Hellix',
                          fontSize: 14),
                    ),
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
              CarouselSlider(
                carouselController: CarouselControllerEx,
                options: CarouselOptions(
                    height: 200.0,
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
                items: [1, 2, 3, 4, 5].map((i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: 100,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        height: 400,
                        decoration: BoxDecoration(color: Colors.white70),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.favorite_outline,
                              color: Colors.red,
                            ),
                            Image.asset("images/pic(${i}).png",
                                fit: BoxFit.cover)
                          ],
                        )),
                  );
                }).toList(),
              ),
              SizedBox(),
              DotsIndicator(
                dotsCount: 5,
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        _prevItem();
                        setState(() {});
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                    IconButton(
                      onPressed: () {
                        _nextItem();
                        setState(() {});
                      },
                      icon: Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _prevItem() {
    if (currentindex == 0) {
      CarouselControllerEx.animateToPage(4);
      currentindex = 4;
      sliderIndex = currentindex;
    } else {
      CarouselControllerEx.previousPage();
      currentindex--;
      sliderIndex = currentindex;
    }
  }

  void _nextItem() {
    if (currentindex == 4) {
      CarouselControllerEx.animateToPage(0);
      currentindex = 0;
      sliderIndex = currentindex;
    } else {
      CarouselControllerEx.nextPage();
      currentindex++;
      sliderIndex = currentindex;
    }
  }
}
