import 'package:bellasareas/provider/property_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PropertyDetail extends StatelessWidget {
  final id;
  PropertyDetail(this.id);
  @override
  Widget build(BuildContext context) {
    final property = Provider.of<PropertyProvider>(context).findById(id);
    final propertyKeyDetails = property.details.keys.toList();
    final propertyValueDetails = property.details.values.toList();
    print(propertyKeyDetails);
    print(propertyValueDetails);
    return Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Text(
                "Property Details",
                style: TextStyle(fontSize: 20),
              ),
              Divider(
                thickness: 2,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: propertyKeyDetails.length.toDouble() * 28,
                child: ListView.builder(
                    itemBuilder: (ctx, index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                propertyKeyDetails[index] + " :",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                propertyValueDetails[index].toString(),
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                    itemCount: propertyKeyDetails.length),
              ),
            ],
          ),
        ));
  }
}
