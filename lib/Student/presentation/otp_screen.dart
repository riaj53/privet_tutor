import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:privet_tutor/Student/presentation/home_screen.dart';
import 'package:privet_tutor/Student/presentation/user_info_screen.dart';
import 'package:privet_tutor/common/color.dart';
import 'package:privet_tutor/common/myButton.dart';
import 'package:privet_tutor/provider/auth_provider.dart';
import 'package:privet_tutor/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;
  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      backgroundColor: Mycolor.mainColor,
      body: SafeArea(
        child: isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Otp',
                      style: TextStyle(fontSize: 25.sp, color: Colors.white),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Pinput(
                      length: 6,
                      showCursor: true,
                      defaultPinTheme: PinTheme(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.purple.shade300)),
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 20.sp)),
                      onCompleted: (value) {
                        setState(() {
                          otpCode = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    MyButton(
                        title: "verify",
                        ontp: () {
                          if (otpCode != null) {
                            verifyOtp(context, otpCode!);
                          } else {
                            showSnackBar(
                                context: context,
                                content: "Enter 6-Digit code");
                          }
                        }),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      "didn't receive code?",
                      style: TextStyle(color: Colors.white),
                    ),
                    InkWell(
                      child: Text(
                        "Resend code",
                        style: TextStyle(color: Mycolor.buttonColor),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
        context: context,
        verificationId: widget.verificationId,
        userOtp: userOtp,
        onSucccess: () {
          ap.checkExistingUser().then((value) async {
            if (value == true) {
//exist user
              ap.getDataFromFirebase().then((value) => ap.saveUserDataSp().then(
                  (value) => ap.setSignin().then((value) =>
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (route) => false))));
            } else {
//new user
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => UserInfoScreen()),
                  (route) => false);
            }
          });
        });
  }
}
