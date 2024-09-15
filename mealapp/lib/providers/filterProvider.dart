import 'package:flutter_riverpod/flutter_riverpod.dart';

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
