import 'package:flutter/material.dart';
import 'package:multiscreen_app/data/dummy_data.dart';
import 'package:multiscreen_app/models/category.dart';
import 'package:multiscreen_app/models/meal.dart';
import 'package:multiscreen_app/screens/meals.dart';
import 'package:multiscreen_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.avaliableMeals,
  });

  final List<Meal> avaliableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationControllers;

  @override
  void initState() {
    super.initState();
    _animationControllers = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationControllers.forward();
  }

  @override
  void dispose() {
    _animationControllers.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.avaliableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    return AnimatedBuilder(
      animation: _animationControllers,
      child: GridView(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            ),
        ],
      ),
      builder: (context, child) => Padding(
        padding: EdgeInsets.only(top: 100 - _animationControllers.value * 100),
        child: child,
      ),
    );
  }
}
