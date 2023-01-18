import 'package:flutter/material.dart';
import 'package:lab5/domain/Category.dart';

//aici se constuieste o categorie
buildPopularCard(Category category) {
  return Padding(
      padding: EdgeInsets.all(2),
      child: GestureDetector(
        /*onTap: () {
          Get.to(ProductDetail(product: product));
        },*/
        child: _productCard(category),
      ));
}

Column _productCard(Category category) {
  return Column(
    children: [
      Container(
      //elevation: 0,
        //ca containerul sa fie rotund
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(55),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7
              )
            ]
        ),
        child: GridTile(
          child: Column(
            children: [
              _imageIcon(category),
            ],
          ),
        ),
    ),
    Padding(
    padding: EdgeInsets.symmetric(horizontal: 7),
    child: Padding(
      padding: EdgeInsets.only(top: 5),
      child: _title(category),
    )
    ),
  ]
  );
}

SizedBox _title(Category category) {
  return SizedBox(
      width: 60,
      child: Text(
      '${category.name.substring(0, 10)}..',
      style: const TextStyle(
        fontWeight: FontWeight.normal,
        color: Colors.black,
        ),
      ),
  );
}

Container _imageIcon(Category category) {
  return Container(
    height: 60,
    width: 60,
    padding: EdgeInsets.all(15),
    child: Center(
      child: Image.network(
        category.icon,
        fit: BoxFit.cover,
      ),
    )
  );
}
