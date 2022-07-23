import 'package:baatchet/constant.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passEditingController = TextEditingController();
  ValueNotifier<bool> isEmailEmpty = ValueNotifier(false);
  ValueNotifier<bool> isPassEmpty = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: BoxDecoration(gradient: blueGradient),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 60),
              Image.asset('assets/Img/logo.png', height: 150),
              const SizedBox(height: 30),
              getTextContainer(theme, nameEditingController, false, 'Name'),
              const SizedBox(height: 10),
              getTextContainer(theme, emailEditingController, false, 'Email'),
              const SizedBox(height: 10),
              getTextContainer(theme, passEditingController, false, 'Password'),
            ],
          ),
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
