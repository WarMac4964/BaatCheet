import 'package:baatchet/screens/screens.dart';
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
            theme: ThemeData(
              primarySwatch: Colors.amber,
              backgroundColor: Colors.amber,
              accentColor: Colors.deepPurple,
              accentColorBrightness: Brightness.dark,
              buttonTheme: ButtonTheme.of(context).copyWith(
                buttonColor: Colors.amber,
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              textTheme: ThemeData.light().textTheme.copyWith(
                    button: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                      fontSize: 15,
                    ),
                    headline1: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Colors.white,
                    ),
                    subtitle1: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    bodyText2: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
                      fontSize: 15,
                    ),
                    bodyText1: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
            ),
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, userSnapshot) {
                if (userSnapshot.hasData) {
                  return ChatScreen();
                } else {
                  return NewAuthScreen();
                }
              },
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
