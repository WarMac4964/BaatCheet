import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewAuthScreen extends StatefulWidget {
  @override
  State<NewAuthScreen> createState() => _NewAuthScreenState();
}

class _NewAuthScreenState extends State<NewAuthScreen> {
  final googleImg = Image.asset("assets/Img/google.png");
  final facebookImg = Image.asset("assets/Img/facebook.png");

  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
      String email, String password, String username, bool isLogin, BuildContext ctx, File image) async {
    UserCredential userCredential;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
        print(userCredential);
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        final ref = FirebaseStorage.instance.ref().child('user_image').child(userCredential.user.uid + '.jpg');

        await ref.putFile(image).whenComplete(() => null);

        final url = await ref.getDownloadURL();

        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user.uid)
            .set({'username': username, 'email': email, 'url': url});

        print(userCredential);
      }
    } on PlatformException catch (err) {
      var message = 'An error occured, please check your credentials';
      if (err.message != null) {
        message = err.message;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      var message = '';
      if (err.message != null) {
        message = err.message;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _password = '';
  var _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      _submitAuthForm(_userEmail.trim(), _password.trim(), _userName.trim(), _isLogin, context, _userImageFile);
    }
  }

  Widget buildInputField(String displayText, bool pass) {
    return pass
        ? Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Form(
              child: TextFormField(
                key: ValueKey('username'),
                onSaved: (newValue) {
                  _userName = newValue;
                },
                style: TextStyle(color: Colors.black87),
                obscureText: true,
                // onFieldSubmitted: (value) => next,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: displayText,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Username is requried';
                  } else if (value.length < 4) {
                    return 'Please provide atleast 4 characters';
                  } else {
                    return null;
                  }
                },
              ),
            ),
          )
        : Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Form(
              key: _formKey,
              child: TextFormField(
                key: ValueKey('email'),
                onSaved: (newValue) {
                  _userEmail = newValue;
                },
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.black87),
                validator: (value) {
                  if (value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email address';
                  } else {
                    return null;
                  }
                },
                // onFieldSubmitted: (value) => next,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: displayText,
                ),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.lerp(Color.fromRGBO(139, 199, 255, 0.4),
      //     Color.fromRGBO(139, 199, 255, 1), 0.7),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(139, 199, 255, 0.7),
              Color.fromRGBO(139, 199, 255, 1),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 70,
              ),
              Center(
                child: Text(
                  "BaatCheet",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              // const SizedBox(
              //   height: 7,
              // ),
              Text(
                "Text Messaging Application",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                padding: EdgeInsets.only(left: 15),
                alignment: Alignment.bottomLeft,
                child: Text("Hi!", style: Theme.of(context).textTheme.headline1),
              ),
              const SizedBox(
                height: 7,
              ),
              buildInputField("Email", false),
              const SizedBox(
                height: 7,
              ),
              buildInputField("Password", true),
              const SizedBox(
                height: 7,
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: FlatButton(
                  onPressed: _trySubmit,
                  child: Text(
                    "Continue",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                "or",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 7,
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: FlatButton(
                  onPressed: () {},
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.network(
                        "https://ibb.co/kM0J0xH",
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) =>
                            (loadingProgress == null) ? child : CircularProgressIndicator(),
                        errorBuilder: (context, error, stackTrace) => googleImg,
                      ),
                    ),
                    title: Text(
                      "Continue with Google",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: FlatButton(
                  onPressed: () {},
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.network(
                        "https://ibb.co/qrt6k2R",
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) => (loadingProgress == null)
                            ? child
                            : CircularProgressIndicator(
                                color: Colors.black87,
                              ),
                        errorBuilder: (context, error, stackTrace) => facebookImg,
                      ),
                    ),
                    title: Text(
                      "Continue with Facebook",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 7,
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: Row(
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    GestureDetector(onTap: () {}, child: Text("Sign Up", style: Theme.of(context).textTheme.button))
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 15, top: 5),
                child: GestureDetector(
                    onTap: () {}, child: Text("Forget your password", style: Theme.of(context).textTheme.button)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
