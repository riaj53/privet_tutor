import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:privet_tutor/common/myButton.dart';
import 'package:privet_tutor/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PhoneNumberInputPage extends StatefulWidget {
  const PhoneNumberInputPage({super.key});

  @override
  State<PhoneNumberInputPage> createState() => _PhoneNumberInputPageState();
}

class _PhoneNumberInputPageState extends State<PhoneNumberInputPage> {
  final TextEditingController phonControllar = TextEditingController();
  Country selectedcountry = Country(
      phoneCode: '+880',
      countryCode: 'BD',
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "Bangladesh",
      example: "Bangladesh",
      displayName: "Bangladesh",
      displayNameNoCountryCode: "Bangladesh",
      e164Key: "e164Key");
  @override
  Widget build(BuildContext context) {
    phonControllar.selection = TextSelection.fromPosition(
        TextPosition(offset: phonControllar.text.length));
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Add your Phone Number.We will Send you a verification code',
                  style:
                      TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  style: TextStyle(fontSize: 14.sp),
                  keyboardType: TextInputType.phone,
                  controller: phonControllar,
                  onChanged: (value) {
                    phonControllar.text = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Phone Number ',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black12)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black12)),
                    suffixIcon: phonControllar.text.length > 9
                        ? Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.green),
                            child: Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 20,
                            ),
                          )
                        : null,
                    prefixIcon: Container(
                        padding: EdgeInsets.all(12),
                        child: InkWell(
                            onTap: () {
                              showCountryPicker(
                                  countryListTheme: CountryListThemeData(
                                      bottomSheetHeight: 500),
                                  context: context,
                                  onSelect: (value) {
                                    setState(() {
                                      selectedcountry = value;
                                    });
                                  });
                            },
                            child: Text(
                              "${selectedcountry.flagEmoji}${selectedcountry.phoneCode}",
                              style: TextStyle(fontSize: 14.sp),
                            ))),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                MyButton(title: "Login", ontp: () => sendPhoneNumber())
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = phonControllar.text.trim();
    ap.signInWithPhone(context, "${selectedcountry.phoneCode}$phoneNumber");
  }
}
