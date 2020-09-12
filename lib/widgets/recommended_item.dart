import 'dart:math';
import 'package:bellasareas/model/property.dart';
import 'package:bellasareas/provider/property_provider.dart';
import 'package:bellasareas/screen/property_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:bellasareas/utils/custom_theme.dart' as style;

List shuffle(List<Property> items) {
  var random = new Random();

  for (var i = items.length - 1; i > 0; i--) {
    var n = random.nextInt(i + 1);
    var temp = items[i];
    items[i] = items[n];
    items[n] = temp;
  }

  return items;
}

class RecommendedItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final property =
        Provider.of<PropertyProvider>(context, listen: false).recentProperties;
    return CarouselSlider.builder(
        itemCount: property.length,
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: (){
              Navigator.pushNamed(context,PropertyDetailsScreen.routeName,arguments: property[index].id);
            },
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0)
                      ),
                      image: DecorationImage(
                          image: NetworkImage(property[index].images[0]),
                          fit: BoxFit.fill)
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.location_on,color: Colors.white,),
                          Text(property[index].location,style: style.CustomTheme.kTextStyle,)
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text("Rs. ",style: style.CustomTheme.header,),
                          Text(property[index].price.toString(),style: style.CustomTheme.kTextStyle,)
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
        options: CarouselOptions(
          aspectRatio: 4/3,
          autoPlay: false,
          scrollDirection: Axis.horizontal,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
        ));
  }
}
