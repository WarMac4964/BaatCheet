import 'package:baatchet/auth/screens/login_screen.dart';
import 'package:baatchet/constant.dart';
import 'package:baatchet/home/screens/entry_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialisation = Firebase.initializeApp();
    return FutureBuilder(
      future: _initialisation,
      builder: (context, appSnapshot) {
        if (appSnapshot.hasError) {
          return Scaffold(
            body: Container(
              child: Text(
                'Something went wrong!',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          );
        }
        if (appSnapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'BaatChet',
            debugShowCheckedModeBanner: false,
            theme: darkTheme,
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, userSnapshot) {
                if (userSnapshot.hasData) {
                  return EntryPage();
                } else {
                  return LoginScreen();
                }
              },
            ),
          );
        }
        return MaterialApp(home: Scaffold(body: Container(child: Center(child: CircularProgressIndicator.adaptive()))));
      },
    );
  }
}
