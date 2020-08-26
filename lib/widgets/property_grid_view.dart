import 'package:bellasareas/provider/property_provider.dart';
import 'package:bellasareas/widgets/property_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PropertyGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final property = Provider.of<PropertyProvider>(context,listen: false).properties;
    return ListView.builder(
      itemBuilder: (ctx, index) => PropertyGridItem(
        id: property[index].id,
        imageURL: property[index].images[0],
        price: property[index].price,
        location: property[index].location,
        category: property[index].category,
      ),
      itemCount: property.length,
    );
  }
}
