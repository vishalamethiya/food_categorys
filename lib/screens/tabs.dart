import 'package:flutter/material.dart';
import 'package:multiscreen_app/Provider/meals_provider.dart';

import 'package:multiscreen_app/screens/categories.dart';
import 'package:multiscreen_app/screens/filters.dart';
import 'package:multiscreen_app/screens/meals.dart';
import 'package:multiscreen_app/widgets/main_drawer.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiscreen_app/Provider/filter_provider.dart';
import 'package:multiscreen_app/Provider/favorites_mealsprovider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  //final List<Meal> _favoriteMeal = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  // void _toggleMealFavoriteStatus(Meal meal) {
  //   final isExising = _favoriteMeal.contains(meal);

  //   if (isExising) {
  //     setState(() {
  //       _favoriteMeal.remove(meal);
  //     });
  //     shoeInfoMessage('Meal is no longer a Favorite...');
  //   } else {
  //     setState(() {
  //       _favoriteMeal.add(meal);
  //     });
  //     shoeInfoMessage('Marked as a Favorite');
  //   }
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FilterScreen(currentFilter: _selectedFilters),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(context) {
    final meals = ref.watch(mealsprovider);

    final avaliableMeals = meals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Widget activePage = CategoriesScreen(
      avaliableMeals: avaliableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeal = ref.watch(favoriteMealProvider);
      activePage = MealsScreen(
        meals: favoriteMeal,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            _selectPage(index);
          },
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
          ]),
    );
  }
}
