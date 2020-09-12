import 'package:bellasareas/widgets/popular_property.dart';
import 'package:bellasareas/widgets/recent_added.dart';
import 'package:bellasareas/widgets/recommended.dart';
import 'package:flutter/material.dart';

class OverViewItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PopularProperty(),
        Recommended(),
        RecentAdded(),
      ],
    );
  }
}
