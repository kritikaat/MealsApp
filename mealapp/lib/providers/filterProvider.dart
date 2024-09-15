import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/data/categoriesdata.dart';

enum Filter { glutenFree, vegan, lactoseFree, vegetarian }

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegan: false,
          Filter.vegetarian: false
        });

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }

  void setFilters(Map<Filter,bool> chosenFilters){
    state = chosenFilters;
  }
  
}

final FilterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
    (ref) => FilterNotifier());


final FilteredProviders = Provider((ref){
  final activeFilters =  ref.watch(FilterProvider);
  return dummyMeals.where((meal) {
      if(activeFilters[Filter.glutenFree]! && !meal.isGlutenFree){
        return false;
      }
       if(activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
        return false;
      }
       if(activeFilters[Filter.vegetarian]! && !meal.isVegetarian){
        return false;
      }
       if(activeFilters[Filter.vegan]! && !meal.isVegan){
        return false;
      }
      return true;
    },).toList();
});