import 'package:flash_chat_foytingo_v2/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_foytingo_v2/screens/welcome_screen.dart';
import 'package:flash_chat_foytingo_v2/screens/login_screen.dart';
import 'package:flash_chat_foytingo_v2/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      // ignore: missing_return
      builder: (context, snapshot) {
        // if(snapshot.hasError) {
        //   return SomethingWentWrong();
        // }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            theme: ThemeData.dark(),
            initialRoute: WelcomeScreen.id,
            routes: {
              WelcomeScreen.id: (context) => WelcomeScreen(),
              LoginScreen.id: (context) => LoginScreen(),
              RegisterScreen.id: (context) => RegisterScreen(),
              ChatScreen.id: (context) => ChatScreen(),
            },
          );
        }
        //return Loading()
      },
    );
  }
}
