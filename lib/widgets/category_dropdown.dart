import 'package:bellasareas/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryDropDown extends StatefulWidget {
  @override
  _CategoryDropDownState createState() => _CategoryDropDownState();
}

class _CategoryDropDownState extends State<CategoryDropDown> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context);
    final categories = provider.getCategories();
    return Padding(
      padding: EdgeInsets.only(left: 5),
      child: DropdownButton<String>(
        items: categories.map((dropdownStringItem) {
          return DropdownMenuItem<String>(
            value: dropdownStringItem,
            child: Expanded(
              flex: 1,
              child: Text(
                dropdownStringItem,
                style: TextStyle(fontSize: 14),
              ),
            ),
          );
        }).toList(),
        value: provider.selectedCategory,
        onChanged: (value) {
          setState(() {
            provider.selected = value;
          });
        },
      ),
    );
  }
}
