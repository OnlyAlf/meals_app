import 'package:flutter/material.dart';
import 'package:meals_app/mocks/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-deatil_screen';
  final Function toggleFavorite;
  final Function isFavorite;

  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final mealItem = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    Widget sectionTitleWidget(BuildContext context, String text) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          text,
          style: Theme.of(context).textTheme.title,
        ),
      );
    }

    Widget sectionContainerWidget(Widget child) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        height: 150,
        width: 300,
        child: child,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${mealItem.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(alignment: Alignment.topLeft,
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Image.network(
                    mealItem.imageUrl,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        isFavorite(mealId) ? Icons.star: Icons.star_border ,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () =>
                          toggleFavorite(mealId),
                    ),
                  ),
                ],
              ),
            ),
            sectionTitleWidget(context, 'Ingredients'),
            sectionContainerWidget(ListView.builder(
              itemCount: mealItem.ingredients.length,
              itemBuilder: (ctx, index) => Card(
                color: Theme.of(context).accentColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: Text(mealItem.ingredients[index]),
                ),
              ),
            )),
            sectionTitleWidget(context, 'Steps'),
            sectionContainerWidget(
              ListView.builder(
                itemBuilder: (ctx, index) => Column(children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('# ${(index + 1)}'),
                    ),
                    title: Text(mealItem.steps[index]),
                  ),
                  Divider(),
                ]),
                itemCount: mealItem.steps.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
