import 'package:flutter/material.dart';
import 'package:mealapp/models/meals.dart';
import 'package:mealapp/widgets/meal_item.dart';
class MealsScreen extends StatelessWidget{
  const MealsScreen({super.key,required this.meals, required this.title});

  final List<Meal> meals;
  final String title;

  Widget build(context){

    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) =>MealItem(meal: meals[index],),
    );
    if(meals.isEmpty){
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh Oh....nothing here!',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            SizedBox(height: 15,),
            Text(
              'Try Selecting different category',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            )
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: content,
    );
  }
}