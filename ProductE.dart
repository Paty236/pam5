import 'package:flutter/cupertino.dart';

class ProductE {
  Color colour;
  String name;
  String main_image;
  double price;
  String details;
  String size;
  int id;

  ProductE(
      {this.colour,
      this.name,
      this.main_image,
      this.price,
      this.details,
      this.size,
      this.id});

  factory ProductE.fromJson(Map<String, dynamic> json) {
    Color color = getColor(json['colour']);
    return ProductE(
      colour: color,
      name: json['name']?? '',
      main_image: json['main_image']?? '',
      price: json['price']?? '',
      details: json['details']?? '',
      size: json['size']?? '',
      id: json['id']?? '',
    );
  }

  static Color getColor(String color) {
    Color colorColor;
    if (color.toLowerCase() == 'white') {
      colorColor = const Color.fromRGBO(252, 252, 252, 100);
    } else if (color.toLowerCase() == 'blue') {
      colorColor = const Color.fromRGBO(19, 117, 173, 100);
    } else if (color.toLowerCase() == 'red') {
      colorColor = const Color.fromRGBO(222, 22, 22, 100);
    } else if (color.toLowerCase() == 'green') {
      colorColor = const Color.fromRGBO(49, 117, 53, 100);
    }else if (color.toLowerCase() == 'yellow') {
      colorColor = const Color.fromRGBO(226, 245, 54, 100);
    }else if (color.toLowerCase() == 'pink') {
      colorColor = const Color.fromRGBO(224, 141, 223, 100);
    }else {
      colorColor = const Color.fromRGBO(0, 0, 0, 100);
    }
    return colorColor;
  }
}
