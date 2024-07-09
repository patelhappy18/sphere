import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myvoiceapp/View/dashboard/dashboard.dart';
// import 'package:pinput/pinput.dart';
import 'package:myvoiceapp/res/Assets/image_assets.dart';
import 'package:pinput/pinput.dart';

class OTP extends StatefulWidget {
  final String verificationId;

  OTP({super.key, required this.verificationId});

  @override
  State<OTP> createState() {
    return _OTPState();
  }
}

class _OTPState extends State<OTP> {
  String? _selectedValue = '+1';
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showWelcomeToast();
    });
  }

  void _showWelcomeToast() {
    Fluttertoast.showToast(
      msg: "OTP Sent Successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    var code = "";
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                ImageAssets.phoneIcon,
                height: 250,
                width: 250,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Phone Verification',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                "We need your phone number before getting started",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              // Pinput(
              //   defaultPinTheme: defaultPinTheme,
              //   focusedPinTheme: focusedPinTheme,
              //   submittedPinTheme: submittedPinTheme,
              // ),
              const SizedBox(
                height: 20,
              ),
              Pinput(
                length: 6,
                showCursor: true,
                onChanged: (value) {
                  code = value;
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: widget.verificationId,
                              smsCode: code);

                      // Sign the user in (or link) with the credential
                      await auth.signInWithCredential(credential);
                      Navigator.pushNamedAndRemoveUntil(
                          context, 'welcomeScreen', (route) => false);
                    } catch (e) {
                      print("Wrong OTP");
                    }
                  },
                  child: const Text(
                    'Verify Phone Number',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Edit your phone number?',
                      style: TextStyle(color: Colors.purple, fontSize: 14),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
