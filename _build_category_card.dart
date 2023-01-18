import 'package:flutter/material.dart';
import 'package:lab5/constant.dart';

import '../../../components/_star_rating.dart' show showStarIcon;
import '../../../domain/ProductE.dart';

//aici propriu zis se contruieste un element pentru produs
buildCard(ProductE product) {
  return Padding(
    padding: EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white
          ),
          child: imageAndStar(product),
        ),
        _buildPriceRating(product)
      ],
    ),
  );
}

//pret si subtitlu
Padding _buildPriceRating(ProductE product) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titlePrice(product),
        Text(
          product.details,
          maxLines: 2,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.normal,
            color: kGrey,
          ),
        ),
        SizedBox(height: 6),
        Text(
          '\$ ${product.price}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: kGreen,
          ),
        ),
        //showStarRating(3.0, product.color)
      ],
    ),
  );
}

Text _titlePrice(ProductE product) {
  return
      Text(
        product.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        maxLines: 1,
      );
}

//aici se construieste acea stea de peste produs
//pentru a putea suprapune widgeturi folosim stack
Stack imageAndStar(ProductE product) {
  return Stack(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: imageIcon(product),
      ),
      Positioned(
        left: 120.0,
        top: 10,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: Colors.white
          ),
          child: Padding(
            padding: EdgeInsets.all(2),
            child: showStarIcon(),
          )
        )
      )
    ],
  );
}

//imaginea propriu zis din assets
Image imageIcon(ProductE product) {
  return Image.network(
    product.main_image,
    fit: BoxFit.fill,
    height: 200,
  );
}
