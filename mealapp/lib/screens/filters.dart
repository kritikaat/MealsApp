import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/providers/filterProvider.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});


  @override
  ConsumerState<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  var _glutenFreeFilterset = false;
  var _lactoseFreeFilterset = false;
  var _vegeterianFilterset = false;
  var _veganFilterset = false;

  void initState() {
    super.initState();
    final activeFilters =  ref.read(FilterProvider);
    _glutenFreeFilterset = activeFilters[Filter.glutenFree]!;
    _lactoseFreeFilterset = activeFilters[Filter.lactoseFree]!;
    _vegeterianFilterset = activeFilters[Filter.vegetarian]!;
    _veganFilterset = activeFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(onSelectScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == 'meal') {
      //     Navigator.of(context).push(
      //       MaterialPageRoute(
      //         builder: (ctx) => const BottomTabscreen(),
      //       ),
      //     );
      //   }
      // }),
      body: PopScope(
        canPop: true,
        onPopInvoked: (bool didPop) {
          if (didPop) return
          ref.read(FilterProvider.notifier).setFilters({
            Filter.glutenFree: _glutenFreeFilterset,
            Filter.lactoseFree: _lactoseFreeFilterset,
            Filter.vegetarian: _vegeterianFilterset,
            Filter.vegan: _veganFilterset,
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenFreeFilterset,
              onChanged: (isChecked) {
                setState(() {
                  _glutenFreeFilterset = isChecked;
                });
              },
              title: Text(
                'Gluten - Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'only include gluten-free meal.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(
                left: 34,
                right: 22,
              ),
            ),
            SwitchListTile(
              value: _lactoseFreeFilterset,
              onChanged: (isChecked) {
                setState(() {
                  _lactoseFreeFilterset = isChecked;
                });
              },
              title: Text(
                'Lactose - Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'only include lactose-free meal.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(
                left: 34,
                right: 22,
              ),
            ),
            SwitchListTile(
              value: _vegeterianFilterset,
              onChanged: (isChecked) {
                setState(() {
                  _vegeterianFilterset = isChecked;
                });
              },
              title: Text(
                'Vegeterian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'only include vegeterian meal.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(
                left: 34,
                right: 22,
              ),
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
                'only include vegan meal.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(
                left: 34,
                right: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
