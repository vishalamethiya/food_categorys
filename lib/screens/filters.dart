import 'package:flutter/material.dart';
// import 'package:multiscreen_app/screens/tabs.dart';
// import 'package:multiscreen_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:multiscreen_app/Provider/filter_provider.dart';

class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({super.key, required this.currentFilter});

  final Map<Filter, bool> currentFilter;

  @override
  ConsumerState<FilterScreen> createState() {
    return _FilterScreen();
  }
}

class _FilterScreen extends ConsumerState<FilterScreen> {
  var _gluterFreeFilterset = false;
  var _lactoseFreeFilterset = false;
  var _vegetarianFilterset = false;
  var _veganFilterset = false;

  @override
  void initState() {
    super.initState();
    final activeFilter = ref.read(filterProvider);
    _gluterFreeFilterset = activeFilter[Filter.glutenFree]!;
    _lactoseFreeFilterset = activeFilter[Filter.lactoseFree]!;
    _vegetarianFilterset = activeFilter[Filter.vegetarian]!;
    _veganFilterset = activeFilter[Filter.vegan]!;
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(onSelectScreen: (identifier) {
      //   Navigator.of(context).push(
      //     MaterialPageRoute(builder: (ctx) => const TabsScreen()),
      //   );
      // }),
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) return;

          Navigator.of(context).pop({
            Filter.glutenFree: _gluterFreeFilterset,
            Filter.lactoseFree: _lactoseFreeFilterset,
            Filter.vegetarian: _vegetarianFilterset,
            Filter.vegan: _veganFilterset,
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _gluterFreeFilterset,
              onChanged: (isChecked) {
                setState(() {
                  _gluterFreeFilterset = isChecked;
                });
              },
              title: Text(
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include gluten-free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _lactoseFreeFilterset,
              onChanged: (isChecked) {
                setState(() {
                  _lactoseFreeFilterset = isChecked;
                });
              },
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include lactose-free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _vegetarianFilterset,
              onChanged: (isChecked) {
                setState(() {
                  _vegetarianFilterset = isChecked;
                });
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include vegetarian meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _veganFilterset,
              onChanged: (isChecked) {
                setState(() {
                  _veganFilterset = isChecked;
                });
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include vegan meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
