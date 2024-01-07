import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:phn_auth/otpscreen.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Auth"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: TextField(
            controller: phoneController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter Phone Number",
              icon: Icon(Icons.phone),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24)
              )
            ),
          ),
        ),
        SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.verifyPhoneNumber(
                //phoneNumber: '+${phoneController.text}',
                verificationCompleted: (PhoneAuthCredential credential) {
                  // Handle the verification completed event, if needed
                  print("Verification completed: $credential");
                },
                verificationFailed: (FirebaseAuthException e) {
                  // Handle the verification failed event, if needed
                  print("Verification failed: ${e.message}");
                },
                codeSent: (String verificationId, int? resendToken) {
                  // Handle the code sent event, if needed
                  //print("Code sent: $verificationId");
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context)=>OTPScreen(verificationid: verificationId))
                  );
                },
                codeAutoRetrievalTimeout: (String verificationId) {
                  // Handle the code auto-retrieval timeout event, if needed
                  print("Code auto-retrieval timeout: $verificationId");
                },
                phoneNumber: phoneController.text.toString()
              );
            },
            child: Text("Verify Phone Number"),
          ),
        ],
      ),
    );
  }
}