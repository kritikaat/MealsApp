import 'package:flutter/material.dart';
import 'package:mealapp/data/categoriesdata.dart';
import 'package:mealapp/models/category_model.dart';
import 'package:mealapp/screens/category_gridItems.dart';
import 'package:mealapp/screens/meals.dart';

class Categoriesitems extends StatelessWidget {
  const Categoriesitems({super.key});

  void _SelectedCategory(BuildContext context, Category category) {
    dummyMeals.where((Meal)=> Meal.categories.contains(category.id),);

    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (ctx) => MealsScreen(
            meals: dummyMeals, 
            title: category.title)),
    );
  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your Category'),
      ),
      body: GridView(
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
                _SelectedCategory(context,category);
              },
            )
        ],
      ),
    );
  }
}
