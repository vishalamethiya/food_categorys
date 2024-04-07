import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:multiscreen_app/models/meal.dart';

class FavoritesMealProvider extends StateNotifier<List<Meal>> {
  FavoritesMealProvider() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsfavorite = state.contains(meal);

    if (mealIsfavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealProvider =
    StateNotifierProvider<FavoritesMealProvider, List<Meal>>((ref) {
  return FavoritesMealProvider();
});
