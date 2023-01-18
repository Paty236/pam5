import 'package:lab5/domain/ProductE.dart';
import 'package:flutter/cupertino.dart';

import 'Review.dart';

class ProductReview extends ProductE {
  List<Review> reviews;
  ProductReview(
  Color colour,
  String name,
  String main_image,
  double price,
  String details,
  String size,
  int id,
      this.reviews,
      ) : super(colour: colour, name: name, main_image: main_image, price: price, details: details, size: size, id: id);

  factory ProductReview.fromJson(Map<String, dynamic> json) {
    var reviewJsonList = json['reviews'] as List;
    List<Review> reviews = reviewJsonList.map((review) => Review.fromJson(review)).toList();
    Color color = ProductE.getColor(json['colour']);
    return ProductReview(color,
        json['name']?? '',
        json['main_image']?? '',
        json['price']?? '',
        json['details']?? '',
        json['size']?? '',
        json['id']?? '',
        reviews);
  }
}