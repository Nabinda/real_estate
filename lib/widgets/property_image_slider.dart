import 'package:carousel_pro/carousel_pro.dart';
import 'package:bellasareas/provider/property_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PropertyImageSlider extends StatefulWidget {
  final id;
  PropertyImageSlider(this.id);
  @override
  _PropertyImageSliderState createState() => _PropertyImageSliderState(id);
}

class _PropertyImageSliderState extends State<PropertyImageSlider> {
  final id;
  _PropertyImageSliderState(this.id);
  List<NetworkImage> image = <NetworkImage>[];
  @override
  Widget build(BuildContext context) {
    final imageURL = Provider.of<PropertyProvider>(context).getImageURL(id);
    for (int i = 0; i < imageURL.length; i++) {
      image.add(NetworkImage(imageURL[i]));
    }
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,
      child: Carousel(
        images: image,
        animationDuration: Duration(seconds: 2),
        dotSize: 5.0,
        dotSpacing: 20.0,
        dotColor: Colors.black,
        indicatorBgPadding: 2.0,
        dotBgColor: Colors.grey.withOpacity(0.5),
      ),
    );
  }
}
