import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> categoryMeals;
  var _isDataLoaded = false;

  @override
  void didChangeDependencies() {
    if (!_isDataLoaded) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      categoryMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _isDataLoaded = true;
    }
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {
    void removeItem(String mealId) {
      setState(() {
        categoryMeals.removeWhere((meal) => meal.id == mealId);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: categoryMeals != null && categoryMeals.isNotEmpty
          ? ListView.builder(
              itemBuilder: (ctx, index) {
                return MealItem(
                  id: categoryMeals[index].id,
                  title: categoryMeals[index].title,
                  affordability: categoryMeals[index].affordability,
                  complexity: categoryMeals[index].complexity,
                  imageUrl: categoryMeals[index].imageUrl,
                  duration: categoryMeals[index].duration,
                );
              },
              itemCount: categoryMeals.length,
            )
          : Center(
              child: Text(
                'No Meals',
                style: (TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).primaryColor)),
              ),
            ),
    );
  }
}
