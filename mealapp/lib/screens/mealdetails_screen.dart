import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/models/meals.dart';
import 'package:mealapp/providers/favorite_meals.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({super.key, required this.meal});
  final Meal meal;

  Widget build(context, WidgetRef ref) {
    final favoritemeals = ref.watch(favoriteMealsprovider);
    final isFavorite = favoritemeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasadded = ref
                  .read(favoriteMealsprovider.notifier)
                  .toggleFavoriteStatut(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    wasadded ? 'meal is added to favorites' : 'meal is remived form favorites'),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (child , Animation){
                return RotationTransition(
                turns: Tween(
                  begin: 0.8,
                  end: 1.0,
                ).animate(Animation),
                child: child,
              );
              },
              child: Icon( 
                isFavorite ? Icons.star_outlined : Icons.star_border,
                key: ValueKey(isFavorite),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 14,
            ),
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 14,
            ),
            for (final steps in meal.steps)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  steps,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
