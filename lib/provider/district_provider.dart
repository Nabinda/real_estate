import 'package:flutter/cupertino.dart';

class DistrictProvider extends ChangeNotifier {
  List<String> _districts = ["Kathmandu", "Pokhara", "Butwal"];
  String selectedDistrict = "Kathmandu";
  List<String> getDistricts() {
    return [..._districts];
  }

  String get selected {
    return selectedDistrict;
  }

  set selected(String selected) {
    selectedDistrict = selected;
    notifyListeners();
  }
}
