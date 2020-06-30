import 'package:bellasareas/provider/district_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DistrictDropDown extends StatefulWidget {
  @override
  _DistrictDropDownState createState() => _DistrictDropDownState();
}

class _DistrictDropDownState extends State<DistrictDropDown> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DistrictProvider>(context);
    final district = provider.getDistricts();

    return Padding(
      padding: EdgeInsets.only(left: 2),
      child: DropdownButton<String>(
        items: district.map((dropdownStringItem) {
          return DropdownMenuItem<String>(
            value: dropdownStringItem,
            child: Expanded(
              flex: 1,
              child: Text(
                dropdownStringItem,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          );
        }).toList(),
        value: provider.selectedDistrict,
        onChanged: (value) {
          setState(() {
            provider.selected = value;
          });
        },
      ),
    );
  }
}
