import 'package:flutter/cupertino.dart';

Row buildActionBar() {
  return Row(
    children: [
      Text(
        'Categories',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
      Spacer(),
      GestureDetector(
        child: Icon(
          CupertinoIcons.profile_circled,
          size: 45,
        ),
      ),
    ],
  );
}
