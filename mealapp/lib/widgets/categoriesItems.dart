import 'package:flutter/material.dart';
import 'package:mealapp/data/categoriesdata.dart';
import 'package:mealapp/models/category_model.dart';
import 'package:mealapp/models/meals.dart';
import 'package:mealapp/screens/category_gridItems.dart';
import 'package:mealapp/screens/meals.dart';

class Categoriesitems extends StatelessWidget {
  const Categoriesitems({super.key, required this.onTogglefavorite});

   final void Function(Meal meal) onTogglefavorite;

  void _SelectedCategory(BuildContext context, Category category) {
    final filteredMeals = dummyMeals.where((meal)=> meal.categories.contains(category.id),).toList();

    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (ctx) => MealsScreen(
            meals: filteredMeals, 
            title: category.title,
            onTogglefavorite: onTogglefavorite,),),
    );
  }

  Widget build(context) {
    return GridView(
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
    );
  }
}
