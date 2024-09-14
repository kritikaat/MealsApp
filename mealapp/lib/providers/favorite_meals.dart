import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/models/meals.dart';

class favoriteMealsNotifier extends StateNotifier<List<Meal>>{
  favoriteMealsNotifier() : super([]);

  bool toggleFavoriteStatut(Meal meal){
    final mealIsFavorite = state.contains(meal);

    if(mealIsFavorite){
      state = state.where((m)=> m.id != meal.id).toList();
      return false;
    }else{
      state = [...state,meal];
      return true;
    }
  }
}

final favoriteMealsprovider = StateNotifierProvider<favoriteMealsNotifier, List<Meal>> (
  (ref){
    return favoriteMealsNotifier();
},);