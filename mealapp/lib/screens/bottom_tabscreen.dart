import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/screens/filters.dart';
import 'package:mealapp/screens/meals.dart';
import 'package:mealapp/screens/categoriesItems.dart';
import 'package:mealapp/widgets/main_drawer.dart';
import 'package:mealapp/providers/favorite_meals.dart';
import 'package:mealapp/providers/filterProvider.dart';

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


  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
     await Navigator.of(context).push<Map<Filter,bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(),
        ),
      );
    }
  }

  Widget build(context) {
   
    final availableMeals = ref.watch(FilteredProviders);

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
