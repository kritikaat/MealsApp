import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/data/categoriesdata.dart';
import 'package:mealapp/screens/filters.dart';
import 'package:mealapp/screens/meals.dart';
import 'package:mealapp/widgets/categoriesItems.dart';
import 'package:mealapp/widgets/main_drawer.dart';
import 'package:mealapp/providers/favorite_meals.dart';

const kInitialFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree : false,
    Filter.vegetarian : false,
    Filter.vegan : false
  };

class BottomTabscreen extends ConsumerStatefulWidget {
  const BottomTabscreen({super.key});

  ConsumerState<BottomTabscreen> createState() {
    return _BottomTabscreenState();
  }
}

class _BottomTabscreenState extends ConsumerState<BottomTabscreen> {
  int _selectedPageIndex = 0;

  Map<Filter,bool> _selectedFilters = kInitialFilters;


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
          builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters,),
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
      availableMeals: availableMeals,
    );
    var activepagetitles = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoritemeals = ref.watch(favoriteMealsprovider);
      activeScreen = MealsScreen(
        meals: favoritemeals,
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
        items:const [
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
