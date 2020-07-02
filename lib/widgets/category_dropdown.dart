import 'package:bellasareas/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryDropDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context);
    final categories = provider.getCategories();
    return Padding(
      padding: EdgeInsets.only(left: 5),
      child: DropdownButton<String>(
        dropdownColor: Colors.blueGrey,
        items: categories.map((dropdownStringItem) {
          return DropdownMenuItem<String>(
            value: dropdownStringItem,
            child: Text(
              dropdownStringItem,
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          );
        }).toList(),
        value: provider.selectedCategory,
        onChanged: (value) {
          provider.selected = value;
        },
      ),
    );
  }
}
