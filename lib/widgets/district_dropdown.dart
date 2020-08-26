import 'package:bellasareas/provider/district_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bellasareas/utils/custom_theme.dart' as style;

class DistrictDropDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DistrictProvider>(context);
    final district = provider.getDistricts();

    return Padding(
      padding: EdgeInsets.only(left: 2),
      child: DropdownButton<String>(
        dropdownColor: style.CustomTheme.circularColor1,
        items: district.map((dropdownStringItem) {
          return DropdownMenuItem<String>(
            value: dropdownStringItem,
            child: Text(
              dropdownStringItem,
              style: style.CustomTheme.kTextStyle,
            ),
          );
        }).toList(),
        value: provider.selectedDistrict,
        onChanged: (value) {
          provider.updateSelected = value;
        },
      ),
    );
  }
}
