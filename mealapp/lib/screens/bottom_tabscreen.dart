import 'package:flutter/material.dart';
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
    
    void _selectPage(int index){
      setState(() {
        _selectedPageIndex = index;
      });
    }

    Widget build(context){

      Widget activeScreen = const Categoriesitems();
      var activepagetitles = 'Categories';

      if(_selectedPageIndex == 1){
          activeScreen = const MealsScreen(meals: []);
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