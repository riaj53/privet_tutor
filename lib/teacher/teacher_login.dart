import 'package:flutter/material.dart';
import 'package:privet_tutor/common/color.dart';

class TeacherLogin extends StatefulWidget {
  const TeacherLogin({super.key});

  @override
  State<TeacherLogin> createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mycolor.mainColor,
      body: Center(
        child: Text('Teacher'),
      ),
    );
  }
}
