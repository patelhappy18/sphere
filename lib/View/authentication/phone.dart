import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myvoiceapp/View/authentication/otp.dart';
import 'package:myvoiceapp/res/Assets/image_assets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Phone extends StatefulWidget {
  final void Function() otp;

  Phone(this.otp, {super.key});

  State<Phone> createState() {
    return _Phone();
  }
}

class _Phone extends State<Phone> {
  String? _selectedValue = '+1';
  String phone = '';
  final _formKey = GlobalKey<FormState>();

  void _showError(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color.fromARGB(255, 218, 42, 30),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Form(
                key: _formKey,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 60,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedValue,
                          hint: Text('+1'),
                          items: <String>['+1', '+91'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedValue = newValue;
                            });
                          },
                        ),
                      ),
                      const Text(
                        '|',
                        style: TextStyle(fontSize: 35, color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            phone = value;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Phone',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    if (phone.isEmpty) {
                      _showError('Please enter a phone number');
                    } else if (phone.length != 10) {
                      _showError('Phone number must be 10 digits');
                    } else {
                      String phoneNumber = _selectedValue! + phone;
                      print(phoneNumber);

                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: phoneNumber,
                        verificationCompleted:
                            (PhoneAuthCredential credential) {
                          // Handle successful verification completion
                          // print('Verification Done :)');
                          _showError('Verification Successfull');
                        },
                        verificationFailed: (FirebaseAuthException e) {
                          // Log the error
                          // print('Verification failed: ${e.message}');
                          _showError('Verification failed: ${e.message}');
                        },
                        codeSent: (String verificationId, int? resendToken) {
                          // Navigate to OTP verification page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OTP(
                                verificationId: verificationId,
                              ),
                            ),
                          );
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {
                          // Handle the auto retrieval timeout
                          _showError(
                              'Auto retrieval timed out. Please enter the verification code manually.');
                        },
                      );
                    }
                  },
                  child: const Text(
                    'Send OTP',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
