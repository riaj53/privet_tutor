import 'package:flutter/material.dart';
import 'package:privet_tutor/Student/presentation/home_screen.dart';
import 'package:privet_tutor/common/color.dart';
import 'package:privet_tutor/provider/auth_provider.dart';
import 'package:privet_tutor/student_or_tutor.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Mycolor.mainColor,
      body: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Center(
            child: Text(
              'WellCome',
              style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          ElevatedButton(
              onPressed: () async {
                if (ap.isSignIn == true) {
                  await ap.getdataFromSP().whenComplete(() =>
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen())));
                } else {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentOrTutor()));
                }
              },
              child: Text('Go'))
        ],
      ),
    );
  }
}
