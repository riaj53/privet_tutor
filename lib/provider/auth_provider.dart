import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:privet_tutor/Student/presentation/otp_screen.dart';
import 'package:privet_tutor/models/user_model.dart';
import 'package:privet_tutor/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSignIn = false;
  bool get isSignIn => _isSignIn;
  bool _isLoadin = false;
  bool get isLoading => _isLoadin;
  String? _uId;
  String get uid => _uId!;
  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  AuthProvider() {
    checkSignIn();
  }

  void checkSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignIn = s.getBool("is_SignedIn") ?? false;
    notifyListeners();
  }

  Future setSignin() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool('_isSignedIn', true);
    _isSignIn = true;
    notifyListeners();
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendTocken) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        OtpScreen(verificationId: verificationId)));
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message.toString());
    }
  }

  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSucccess,
  }) async {
    _isLoadin = true;
    notifyListeners();
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;

      if (user != null) {
        _uId = user.uid;
        onSucccess();
      }
      _isLoadin = false;
      notifyListeners();
    } on FirebaseException catch (e) {
      showSnackBar(context: context, content: e.message.toString());
      _isLoadin = false;
      notifyListeners();
    }
  }

  //  DATABASE oPARETION
  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("users").doc(_uId).get();
    if (snapshot.exists) {
      print('UserExist');
      return true;
    } else {
      print('New User');
      return false;
    }
  }

  void saveUserDataToFirebase(
      {required BuildContext context,
      required UserModel userModel,
      required File profilepic,
      required Function onSuccess}) async {
    _isLoadin = true;
    notifyListeners();
    try {
      //uploading image to firebase storage
      await storeFiletoFirebase("profilePic/$_uId", profilepic).then((value) {
        userModel.profilePic = value;
        userModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
        userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        userModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
      });
      _userModel = userModel;
      //uploading to databass
      await _firebaseFirestore
          .collection("users")
          .doc(_uId)
          .set(userModel.toMap())
          .then((value) {
        onSuccess();
        _isLoadin = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message.toString());
      _isLoadin = false;
      notifyListeners();
    }
  }

  Future<String> storeFiletoFirebase(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future getDataFromFirebase() async {
    await _firebaseFirestore
        .collection("users")
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _userModel = UserModel(
          name: snapshot['name'],
          email: snapshot['email'],
          bio: snapshot['bio'],
          profilePic: snapshot['profilePic'],
          createdAt: snapshot['createdAt'],
          phoneNumber: snapshot['phoneNumber'],
          uid: snapshot['uid']);
      _uId = userModel.uid;
    });
  }

  //store data localy
  Future saveUserDataSp() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("user_model", jsonEncode(userModel.toMap()));
  }

  //get data from localy
  Future getdataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? '';
    _userModel = UserModel.fromMap(jsonDecode(data));
    _uId = _userModel!.uid;
    notifyListeners();
  }

  Future userSignOut() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    _firebaseAuth.signOut();
    _isSignIn = false;
    notifyListeners();
    s.clear();
  }
}
