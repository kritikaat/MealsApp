import 'package:flutter/material.dart';
import 'package:mealapp/models/category_model.dart';

class CategoryGriditems extends StatelessWidget{
  CategoryGriditems({super.key, required this.category,required this.onSelectedCategory});

  final Category category;
  final void Function() onSelectedCategory;

  Widget build(context){
    return InkWell(
      onTap: onSelectedCategory,
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
            category.color.withOpacity(0.55),
            category.color.withOpacity(0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}