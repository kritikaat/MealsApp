import 'package:flutter/material.dart';
import 'package:mealapp/data/categoriesdata.dart';
import 'package:mealapp/models/meals.dart';
import 'package:mealapp/screens/filters.dart';
import 'package:mealapp/screens/meals.dart';
import 'package:mealapp/widgets/categoriesItems.dart';
import 'package:mealapp/widgets/main_drawer.dart';

const kInitialFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree : false,
    Filter.vegetarian : false,
    Filter.vegan : false
  };

class BottomTabscreen extends StatefulWidget {
  const BottomTabscreen({super.key});

  State<BottomTabscreen> createState() {
    return _BottomTabscreenState();
  }
}

class _BottomTabscreenState extends State<BottomTabscreen> {
  int _selectedPageIndex = 0;

  final List<Meal> _favoriteMeals = [];

  Map<Filter,bool> _selectedFilters = kInitialFilters;

  void _InfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
        _InfoMessage('Meal is no longer a favorite!');
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _InfoMessage('Marked as favorite!');
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter,bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(),
        ),
      );

      setState(() {
        _selectedFilters = result?? kInitialFilters;
      });
    }
  }

  Widget build(context) {

    final availableMeals = dummyMeals.where((meal) {
      if(_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree){
        return false;
      }
       if(_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
        return false;
      }
       if(_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian){
        return false;
      }
       if(_selectedFilters[Filter.vegan]! && !meal.isVegan){
        return false;
      }
      return true;
    },).toList();

    Widget activeScreen = Categoriesitems(
      onTogglefavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
    );
    var activepagetitles = 'Categories';

    if (_selectedPageIndex == 1) {
      activeScreen = MealsScreen(
        meals: _favoriteMeals,
        onTogglefavorite: _toggleMealFavoriteStatus,
      );
      activepagetitles = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activepagetitles),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
