import 'package:flutter/material.dart';
import 'package:mealapp/models/meals.dart';
import 'package:mealapp/screens/meals.dart';
import 'package:mealapp/widgets/categoriesItems.dart';

class BottomTabscreen extends StatefulWidget{
  const BottomTabscreen({super.key});

  State<BottomTabscreen> createState(){
    return _BottomTabscreenState();
  }
}

class _BottomTabscreenState extends State<BottomTabscreen>{
    int _selectedPageIndex = 0;

    final List<Meal> _favoriteMeals = [];

    void _InfoMessage(String message){
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message),),
      );
    }

    void _toggleMealFavoriteStatus(Meal meal){
      final isExisting = _favoriteMeals.contains(meal);

      if(isExisting){
        setState(() {
          _favoriteMeals.remove(meal);
          _InfoMessage('Meal is no longer a favorite!');
        });
      }else{
        setState(() {
          _favoriteMeals.add(meal);
          _InfoMessage('Marked as favorite!');
        });
      }
    }
    
    void _selectPage(int index){
      setState(() {
        _selectedPageIndex = index;
      });
    }

    Widget build(context){

      Widget activeScreen = Categoriesitems(onTogglefavorite: _toggleMealFavoriteStatus,);
      var activepagetitles = 'Categories';

      if(_selectedPageIndex == 1){
          activeScreen = MealsScreen(meals: _favoriteMeals, onTogglefavorite: _toggleMealFavoriteStatus,);
          activepagetitles = 'Your Favorites';
      }
      return Scaffold(
        appBar: AppBar(
          title: Text(activepagetitles),
        ),
        body: activeScreen ,
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.set_meal),label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.star),label: 'Favorites',),
          ],
        ),
      );
    }
}