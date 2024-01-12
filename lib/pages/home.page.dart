import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe_app/utlis/colors_and_text.utlis.dart';
import 'package:recipe_app/utlis/numbers.utlis.dart';
import 'package:recipe_app/widgets/favourite.widget.dart';
import 'package:recipe_app/widgets/section_header.widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:recipe_app/models/recipe.models.dart';
import '../cubit/recipes_cubit.dart';
import '../widgets/ratingbar.widget.dart';
import '../widgets/search.widget.dart';
import 'package:recipe_app/services/app_routers.sevice.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cubit = RecipeCubit();
  final _opacityController = ValueNotifier<double>(1);
  @override
  void initState() {
    cubit.getRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<RecipeCubit, RecipeState>(
        builder: (context, state) {
          if (state is RecipeLoading) {
            return const SizedBox(
              height: 100,
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            );
          } else if (state is RecipeLoaded) {
            List<Recipes> recipes = state.recipes;
            bool isFavorite = false;
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                leading: const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Numbers.appHorizontalPadding),
                  child: Icon(Icons.notes),
                ),
                actions: const [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Numbers.appHorizontalPadding),
                    child: Icon(
                      Icons.notifications_outlined,
                    ),
                  )
                ],
              ),
              body: AnimatedOpacity(
                opacity: _opacityController.value,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: SingleChildScrollView(
                  controller: ScrollController()
                    ..addListener(() {
                      final offset = 1 -
                          (context.findRenderObject() as RenderBox)
                                  .localToGlobal(Offset.zero)
                                  .dy /
                              100;
                      _opacityController.value = offset.clamp(0, 1);
                    }),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        Numbers.appHorizontalPadding,
                        0,
                        Numbers.appHorizontalPadding,
                        Numbers.appHorizontalPadding),
                    child: Column(
                      children: [
                        // Greating user,Intro,Section1
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Bonjour, ${GetIt.I.get<SharedPreferences>().getString('FullName')}",
                              style: const TextStyle(
                                  color: Color(
                                      ColorsConst.containerBackgroundColor),
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
                        const SizedBox(
                          height: 8,
                        ),
                        const Search(),
                        const SizedBox(),
                        const SectionHeader(
                            sectionName: "Today\'s Fresh Recipes"),
                        RecipesPageView(
                            recipes: recipes, isFavorite: isFavorite),

                        const SizedBox(),
                        const SizedBox(),
                        const SectionHeader(sectionName: "Recommended"),
                        ...List.generate(
                            state.recipes.length,
                            (index) => RecipeCard(
                                recipecard: state.recipes[index],
                                isFavorite: isFavorite)),
                        /*Flexible(
                          child: ListView.builder(
                           
                            itemCount: state.recipes.length,
                            itemBuilder: (context, index) {
                              final recipecard = state.recipes[index];
                              return RecipeCard(
                                  recipecard: recipecard, isFavorite: isFavorite);
                            },
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class RecipesPageView extends StatelessWidget {
  const RecipesPageView({
    super.key,
    required this.recipes,
    required this.isFavorite,
  });

  final List<Recipes> recipes;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: PageView.builder(
        controller: PageController(viewportFraction: .55),
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(ColorsConst.fillColor)),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FavoriteIconButton(isFavorite: isFavorite),
                        Transform.translate(
                          offset: const Offset(45, 0),
                          child: Image.asset(
                            recipes[index].image!,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(),
                    Text(
                      "${recipes[index].meal_type}",
                      style: StyleCons.dishTypeText,
                    ),
                    Text(
                      "${recipes[index].title}",
                      style: StyleCons.dishNameText,
                    ),
                    RatingBars(initrate: recipes[index].rating!),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      "${recipes[index].calories} Calories",
                      style: StyleCons.caloriesText,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(children: [
                      const Icon(
                        Icons.access_time_outlined,
                        color: Color(ColorsConst.containerBackgroundColor),
                        size: 15,
                      ),
                      Text(
                        " ${recipes[index].prep_time} mins",
                        style: StyleCons.serviceText,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.room_service_outlined,
                        color: Color(ColorsConst.containerBackgroundColor),
                        size: 15,
                      ),
                      Text("${recipes[index].serving} Serving",
                          style: StyleCons.serviceText)
                    ])
                  ],
                ),
              ));
        },
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    super.key,
    required this.recipecard,
    required this.isFavorite,
  });

  final Recipes recipecard;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          height: 110,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(ColorsConst.fillColor)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Transform.translate(
                        offset: const Offset(0, -15),
                        child: Image.asset("${recipecard.image}",
                            fit: BoxFit.cover)),
                  ],
                ),
              ),
              const SizedBox(),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "${recipecard.meal_type}",
                        style: StyleCons.dishTypeText,
                      ),
                      Text(
                        "${recipecard.title}",
                        style: StyleCons.dishNameText,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RatingBars(initrate: recipecard.rating!.toDouble()),
                          const SizedBox(),
                          Text(
                            "${recipecard.calories} Calories",
                            style: StyleCons.caloriesText,
                          ),
                        ],
                      ),
                      Row(children: [
                        const Icon(
                          Icons.access_time_outlined,
                          color: Color(ColorsConst.containerBackgroundColor),
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
                          color: Color(ColorsConst.containerBackgroundColor),
                          size: 15,
                        ),
                        Text("${recipecard.serving} Serving",
                            style: StyleCons.serviceText)
                      ])
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FavoriteIconButton(isFavorite: isFavorite),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
