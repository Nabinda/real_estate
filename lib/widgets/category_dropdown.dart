import 'package:bellasareas/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bellasareas/utils/custom_theme.dart' as style;

class CategoryDropDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context);
    final categories = provider.getCategories();
    return Padding(
      padding: EdgeInsets.only(left: 5),
      child: DropdownButton<String>(
        dropdownColor: style.CustomTheme.circularColor1,
        items: categories.map((dropdownStringItem) {
          return DropdownMenuItem<String>(
            value: dropdownStringItem,
            child: Text(
              dropdownStringItem,
              style: style.CustomTheme.kTextStyle,
            ),
          );
        }).toList(),
        value: provider.selectedCategory,
        onChanged: (value) {
          provider.updateSelected = value;
        },
      ),
    );
  }
}
