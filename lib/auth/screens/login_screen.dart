import 'dart:io';

import 'package:baatchet/auth/auth_service.dart';
import 'package:baatchet/auth/screens/signup_screen.dart';
import 'package:baatchet/auth/widgets/auth_helper.dart';
import 'package:baatchet/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterfire_ui/auth.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passEditingController = TextEditingController();
  ValueNotifier<bool> isEmailEmpty = ValueNotifier(false);
  ValueNotifier<bool> isPassEmpty = ValueNotifier(false);
  bool platformIosCheck = Platform.isIOS;

  @override
  void dispose() {
    emailEditingController.dispose();
    passEditingController.dispose();
    super.dispose();
  }

  void checkErrors(context) async {
    if (emailEditingController.text.isEmpty) {
      isEmailEmpty.value = true;
    } else {
      isEmailEmpty.value = false;
    }
    if (passEditingController.text.isEmpty) {
      isPassEmpty.value = true;
    } else {
      isPassEmpty.value = false;
    }
    if (isEmailEmpty.value || isPassEmpty.value) {
      showStatusSnackBar(context, 'Please provide email/password', true);
      return;
    }
    tryLogin(context);
  }

  void tryLogin(BuildContext context) async {
    final response =
        await AuthService().tryLoginWithEmailAndPassword(emailEditingController.text, passEditingController.text);

    if (response['status'] == CallStatus.failed) {
      showStatusSnackBar(context, response['message'], true);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(gradient: blueGradient),
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            const SizedBox(height: 50),
            Image.asset('assets/Img/logo.png', height: 100),
            Text('BaatCheet', style: theme.textTheme.headline1),
            Text('Let\'s talk shall we', style: theme.textTheme.bodyText2),
            const SizedBox(height: 50),
            ValueListenableBuilder(
                valueListenable: isEmailEmpty,
                builder: (context, __, ___) => getTextContainer(theme, emailEditingController, false, 'Email')),
            const SizedBox(height: 10),
            ValueListenableBuilder(
              valueListenable: isPassEmpty,
              builder: (context, __, ___) => getTextContainer(theme, passEditingController, true, 'Password'),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => checkErrors(context),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(color: theme.backgroundColor, borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Text('Continue', style: theme.textTheme.headline6),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                platformIosCheck
                    ? Container(
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: black, borderRadius: BorderRadius.circular(8)),
                        width: (screenSize.width - 60) / 3,
                        child: AppleSignInIconButton(
                          auth: AuthService().firebaseAuth,
                          action: AuthAction.signIn,
                        ),
                      )
                    : const SizedBox(),
                SizedBox(width: platformIosCheck ? 10 : 0),
                Container(
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(8)),
                  width: platformIosCheck ? (screenSize.width - 60) / 3 : (screenSize.width - 50) / 2,
                  child: GoogleSignInIconButton(
                    auth: AuthService().firebaseAuth,
                    action: AuthAction.signIn,
                    clientId: '619339793057-p8f010ujeul21npi3d0dt08jjnp9u3l2.apps.googleusercontent.com',
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: facebookBlue, borderRadius: BorderRadius.circular(8)),
                  width: platformIosCheck ? (screenSize.width - 60) / 3 : (screenSize.width - 50) / 2,
                  child: FacebookSignInIconButton(
                    clientId: '279767870991286',
                    auth: AuthService().firebaseAuth,
                    action: AuthAction.signIn,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => SignUpScreen())),
              child: Align(
                alignment: Alignment.topLeft,
                child: RichText(
                    text: TextSpan(
                        text: 'Don\'t have an account, ',
                        style: theme.textTheme.headline6,
                        children: [TextSpan(text: 'Sign Up?', style: theme.textTheme.button)])),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {},
              child:
                  Align(alignment: Alignment.topLeft, child: Text('Forgot password?', style: theme.textTheme.button)),
            ),
          ],
        )),
      ),
    );
  }

  Widget getTextContainer(ThemeData theme, TextEditingController textEditingController, bool isObsure, String title) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(12),
          border: isObsure
              ? isPassEmpty.value
                  ? Border.all(color: dangerRed, width: 2)
                  : null
              : isEmailEmpty.value
                  ? Border.all(color: dangerRed, width: 2)
                  : null,
        ),
        child: TextField(
          controller: textEditingController,
          decoration: InputDecoration(
              hintText: title,
              hintStyle: isObsure
                  ? isPassEmpty.value
                      ? errorStyle
                      : theme.textTheme.headline6
                  : isEmailEmpty.value
                      ? errorStyle
                      : theme.textTheme.headline6,
              border: InputBorder.none),
          obscureText: isObsure,
        ));
  }
}
