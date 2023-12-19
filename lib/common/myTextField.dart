import 'package:flutter/material.dart';

Widget myTextField(
    {required String title,
    required IconData icon,
    required TextInputType inputType,
    required int maxLine,
    required TextEditingController controller}) {
  return TextFormField(
      controller: controller,
      keyboardType: inputType,
      maxLines: maxLine,
      decoration: InputDecoration(
        prefixIcon: Container(
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.purple),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        hintText: title,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ));
}
