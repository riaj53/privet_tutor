import 'package:flutter/material.dart';
import 'package:privet_tutor/common/color.dart';
import 'package:sizer/sizer.dart';

Widget MyButton({
  required String title,
  required VoidCallback ontp,
}) {
  return InkWell(
    onTap: ontp,
    child: Container(
      height: 6.h,
      width: 25.w,
      decoration: BoxDecoration(
        color: Mycolor.buttonColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
          child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
    ),
  );
}
