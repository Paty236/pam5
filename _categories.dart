import 'package:flutter/material.dart';

Row section(title, param) {
  return Row(
    children: [
      Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      Spacer(),
      Text(
        param,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
      )
    ],
  );
}
