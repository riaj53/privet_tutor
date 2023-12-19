import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:privet_tutor/Student/presentation/student_login.dart';
import 'package:privet_tutor/common/color.dart';

import 'package:sizer/sizer.dart';

class StudentSignUP extends StatefulWidget {
  const StudentSignUP({super.key});

  @override
  State<StudentSignUP> createState() => _StudentSignUPState();
}

class _StudentSignUPState extends State<StudentSignUP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Text('Sign UP',
                style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'Sign In or Sign Up your acoount and get important information from your teacher',
              style: TextStyle(
                  fontFamily: 'GTWalsheimPro',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff777777)),
              textAlign: TextAlign.center,
            ),
            // SizedBox(
            //   height: 5.h,
            // ),
            Image.asset(
              'assets/images/signup.jpg',
              scale: 9,
            ),
            SizedBox(
              height: 5.h,
            ),
            // MyButton(
            //     title: 'Number',
            //     ontp: () {
            //       //  Navigator.push(
            //       //           context,
            //       //           MaterialPageRoute(
            //       //               builder: (context) => PhoneNumberScreen()));
            //     }),
            Container(
              height: 7.h,
              decoration: BoxDecoration(
                  color: Mycolor.buttonColor,
                  borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.call,
                    color: Colors.grey.shade800,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Sign Up With Phone Number',
                    style: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(children: <Widget>[
              const Expanded(
                  child: Divider(
                thickness: 1,
                color: Color(0xffE1E1E1),
              )),
              Text(
                "OR",
                style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.amber,
                    fontWeight: FontWeight.w500),
              ),
              const Expanded(
                  child: Divider(thickness: 1, color: Color(0xffE1E1E1))),
            ]),
            SizedBox(
              height: 2.h,
            ),
            // myButtonWithRow(
            //     color: const Color(0xff1877F2),
            //     text: 'Sign In With Facebook ',
            //     icon: Icons.facebook),
            InkWell(
              onTap: () {},
              child: Container(
                height: 7.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xff0165E1),
                    border: Border.all(color: Color(0xff0165E1)),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/fb.png'),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        'Continue With Facebook ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 7.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffDEDEDE)),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/ic1.png'),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        'Continue With Google ',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            RichText(
              text: TextSpan(
                text: 'Already have an accountt?',
                style: TextStyle(color: Colors.grey.shade600),
                children: [
                  TextSpan(
                    text: ' Sign in',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudentLogin()));
                      },
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
