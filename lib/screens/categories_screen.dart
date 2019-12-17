import 'package:flutter/material.dart';
import 'package:meals_app/widgets/category_item.dart';
import 'package:meals_app/mocks/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = '/main';

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: EdgeInsets.all(25),
        children: DUMMY_CATEGORIES
            .map((catData) => CategoryItem(
                  catData.title,
                  catData.color,
                  catData.id,
                ))
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      );
  }
}
