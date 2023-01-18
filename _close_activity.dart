import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Container closeActivity() {
  return Container(
    child: GestureDetector(
      onTap: () => Get.back(),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            CupertinoIcons.arrow_left,
            color: Colors.black,
          ),
        ),
      ),
    ),
  );
}

const borderRadius = BorderRadius.all(
  const Radius.circular(10.0),
);
