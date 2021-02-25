import 'package:flash_chat_foytingo_v2/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_foytingo_v2/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'chat_screen.dart';

class RegisterScreen extends StatefulWidget {
  static String id = 'register_screen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: 'logo',
                child: Container(
                  height: 150.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(height: 40.0),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldRegisterDecoration.copyWith(
                    hintText: 'Enter your mail'),
              ),
              SizedBox(height: 20.0),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                obscureText: true,
                decoration: kTextFieldRegisterDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(height: 20.0),
              RoundedButton(
                title: 'Register',
                color: Colors.deepOrangeAccent,
                function: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'))
            ],
          ),
        ),
      ),
    );
  }
}
