import 'dart:io';

import 'package:baatchet/auth/auth_service.dart';
import 'package:baatchet/auth/screens/signup_screen.dart';
import 'package:baatchet/auth/widgets/auth_helper.dart';
import 'package:baatchet/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  ValueNotifier<bool> isLoading = ValueNotifier(false);
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
    isLoading.value = true;
    tryLogin(context);
    isLoading.value = false;
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
        decoration: BoxDecoration(color: backgroundBlack),
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            const SizedBox(height: 30),
            Image.asset('assets/Img/logo.png', height: 150),
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
            ValueListenableBuilder(
                valueListenable: isLoading,
                builder: (context, __, ___) {
                  if (isLoading.value) {
                    return Container(height: 20, child: CircularProgressIndicator.adaptive());
                  }
                  return GestureDetector(
                    onTap: () => checkErrors(context),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(color: theme.backgroundColor, borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Text('Continue', style: theme.textTheme.headline6?.copyWith(color: backgroundBlack)),
                    ),
                  );
                }),
            const SizedBox(height: 40),
            getSocialBar(screenSize),
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
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => Dialog(
                        backgroundColor: backgroundBlack,
                        insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        child: Container(
                          height: 220,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Column(
                            children: <Widget>[
                              Image.asset('assets/Img/logo.png', height: 70),
                              const SizedBox(height: 20),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(5)),
                                child: TextField(
                                    controller: emailEditingController,
                                    decoration: InputDecoration(border: InputBorder.none, hintText: 'Email')),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).maybePop();
                                      },
                                      child: Text(
                                        'Cancel',
                                        style: theme.textTheme.subtitle1,
                                      )),
                                  const SizedBox(width: 10),
                                  TextButton(
                                      onPressed: () async {
                                        var response = await AuthService().resetPassword(emailEditingController.text);
                                        showStatusSnackBar(context, response['message'],
                                            response['status'] == CallStatus.failed ? true : false);
                                      },
                                      child: Text(
                                        'Reset',
                                        style: theme.textTheme.subtitle1,
                                      ))
                                ],
                              )
                            ],
                          ),
                        )));
              },
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
          style: theme.textTheme.headline6?.copyWith(color: backgroundBlack),
          decoration: InputDecoration(
              hintText: title,
              hintStyle: isObsure
                  ? isPassEmpty.value
                      ? errorStyle
                      : theme.textTheme.headline6?.copyWith(color: backgroundBlack)
                  : isEmailEmpty.value
                      ? errorStyle
                      : theme.textTheme.headline6?.copyWith(color: backgroundBlack),
              border: InputBorder.none),
          obscureText: isObsure,
        ));
  }
}
