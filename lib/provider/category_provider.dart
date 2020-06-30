import 'package:flutter/cupertino.dart';

class CategoryProvider extends ChangeNotifier {
  List<String> _categories = ["Lands", "Buildings"];
  String selectedCategory = "Lands";

  List<String> getCategories() {
    return [..._categories];
  }

  String get selected {
    return selectedCategory;
  }

  set selected(String selected) {
    selectedCategory = selected;
    notifyListeners();
  }
}
