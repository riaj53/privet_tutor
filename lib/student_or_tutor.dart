import 'package:flutter/material.dart';
import 'package:privet_tutor/Student/presentation/student_login.dart';
import 'package:privet_tutor/common/color.dart';
import 'package:privet_tutor/provider/auth_provider.dart';
import 'package:privet_tutor/teacher/teacher_login.dart';
import 'package:provider/provider.dart';

class StudentOrTutor extends StatefulWidget {
  @override
  _StudentOrTutorState createState() => _StudentOrTutorState();
}

class _StudentOrTutorState extends State<StudentOrTutor> {
  bool _isStudentSelected = false;
  bool _isTeacherSelected = false;

  void _selectStudent() {
    setState(() {
      _isStudentSelected = true;
      _isTeacherSelected = false;
    });
  }

  void _selectTeacher() {
    setState(() {
      _isStudentSelected = false;
      _isTeacherSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mycolor.mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _selectStudent();
              },
              child: Text('Student'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isStudentSelected
                    ? const Color.fromARGB(255, 28, 160, 32)
                    : Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _selectTeacher();
              },
              child: Text('Teacher'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isTeacherSelected
                    ? const Color.fromARGB(255, 28, 160, 32)
                    : Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            Visibility(
              visible: _isStudentSelected || _isTeacherSelected,
              child: ElevatedButton(
                onPressed: () {
                  if (_isStudentSelected) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StudentLogin()),
                    );
                  } else if (_isTeacherSelected) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeacherLogin()),
                    );
                  }
                },
                child: Text('Next'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Mycolor.buttonColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
