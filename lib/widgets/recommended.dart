import 'package:bellasareas/widgets/recommended_item.dart';
import 'package:flutter/material.dart';
import 'package:bellasareas/utils/custom_theme.dart' as style;

class Recommended extends StatelessWidget {
  @override
Widget build(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(left: 10,top: 20),
        child: Text(
          "Recommended",
          style: style.CustomTheme.kTextBlackStyle,
        ),
      ),
      Container(
          margin: EdgeInsets.only(bottom: 15.0,top: 10.0),
          child: RecommendedItem()
      ),
    ],
  );
}
}
