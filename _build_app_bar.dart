import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab5/components/_close_activity.dart';
import 'package:lab5/domain/ProductReview.dart';

AppBar detailAppBar(ProductReview product) {
  return AppBar(
    elevation: 0,
    toolbarHeight: 150,
    backgroundColor: Colors.white,
    flexibleSpace: Image.network(product.main_image, fit: BoxFit.cover),
    leading: closeActivity(),
    actions: const [
      Padding(
        padding: EdgeInsets.all(8),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.star_border,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
    ],
  );
}
