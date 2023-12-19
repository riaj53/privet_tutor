import 'dart:io';

import 'package:flutter/material.dart';
import 'package:privet_tutor/Student/presentation/home_screen.dart';
import 'package:privet_tutor/common/myButton.dart';
import 'package:privet_tutor/common/myTextField.dart';
import 'package:privet_tutor/models/user_model.dart';
import 'package:privet_tutor/provider/auth_provider.dart';
import 'package:privet_tutor/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  File? image;
  final nameControlar = TextEditingController();
  final emailControlar = TextEditingController();
  final bioControlar = TextEditingController();
  @override
  void dispose() {
    nameControlar.dispose();
    emailControlar.dispose();
    bioControlar.dispose();
    super.dispose();
  }

  //for imagePicker
  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 5),
        child: isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => selectImage(),
                      child: image == null
                          ? CircleAvatar(
                              backgroundColor: Colors.purple,
                              radius: 50,
                              child: Icon(
                                Icons.account_circle,
                                size: 50,
                                color: Colors.white,
                              ),
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage: FileImage(
                                image!,
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    myTextField(
                        title: 'Jhon',
                        icon: Icons.person,
                        inputType: TextInputType.name,
                        maxLine: 1,
                        controller: nameControlar),
                    SizedBox(
                      height: 1.h,
                    ),
                    myTextField(
                        title: 'email',
                        icon: Icons.email,
                        inputType: TextInputType.emailAddress,
                        maxLine: 1,
                        controller: emailControlar),
                    SizedBox(
                      height: 1.h,
                    ),
                    myTextField(
                        title: 'bio',
                        icon: Icons.edit,
                        inputType: TextInputType.text,
                        maxLine: 2,
                        controller: bioControlar),
                    SizedBox(
                      height: 5.h,
                    ),
                    MyButton(title: 'Continue', ontp: () => storeData())
                  ],
                ),
              ),
      )),
    );
  }

  //Store Data on Data base
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
        name: nameControlar.text.trim(),
        email: emailControlar.text.trim(),
        bio: bioControlar.text.trim(),
        profilePic: "",
        createdAt: "",
        phoneNumber: "",
        uid: "");
    if (image != null) {
      ap.saveUserDataToFirebase(
          context: context,
          userModel: userModel,
          profilepic: image!,
          onSuccess: () {
            ap.saveUserDataSp().then((value) => ap.setSignin().then((value) =>
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false)));
          });
    } else {
      showSnackBar(context: context, content: 'Please Upload profile Photo');
    }
  }
}
