import 'package:flutter/material.dart';
import 'package:mealapp/data/categoriesdata.dart';
import 'package:mealapp/models/category_model.dart';
import 'package:mealapp/models/meals.dart';
import 'package:mealapp/screens/category_gridItems.dart';
import 'package:mealapp/screens/meals.dart';

class Categoriesitems extends StatefulWidget {
  const Categoriesitems(
      {super.key,
      required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<Categoriesitems> createState() => _CategoriesitemsState();
}

class _CategoriesitemsState extends State<Categoriesitems> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;

  void initState(){
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1
    );

    _animationController.forward();
  }

  void dispose(){
    _animationController.dispose();
    super.dispose();
  }

  void _SelectedCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where(
          (meal) => meal.categories.contains(category.id),
        )
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          meals: filteredMeals,
          title: category.title,
        ),
      ),
    );
  }

  Widget build(context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: [
          for (final category in availableCategories)
            CategoryGriditems(
              category: category,
              onSelectedCategory: () {
                _SelectedCategory(context, category);
              },
            )
        ],
      ),
      builder: (context, child) => Padding(
        padding: EdgeInsets.only(
          top: 100 - _animationController.value * 100,
        ),
        child: child,
      ),
    );
  }
}
