import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tvf/setData.dart';

import 'authservice.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();

  String phoneNo, verificationId, smsCode;
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();

  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: TextField(
                  controller: _firstnameController,

                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'First Name',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: TextField(
                  controller: _lastnameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Last Name',
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'Enter phone number'),
                    onChanged: (val) {
                      setState(() {
                        this.phoneNo = val;
                      });
                    },
                  )),
              codeSent ? Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'Enter OTP'),
                    onChanged: (val) {
                      setState(() {
                        this.smsCode = val;
                      });
                    },
                  )) : Container(),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: RaisedButton(
                      child: Center(child: codeSent ? Text('Login'):Text('Verify')),
                      onPressed: () {
                        setState(() {
                          SetData.userfirstname=_firstnameController.text;
                          SetData.userlastname=_lastnameController.text;

                        });
                        codeSent ? AuthService().signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);

                      }))
            ],
          )),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 2),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }


}