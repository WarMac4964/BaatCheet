import 'package:baatchet/auth/auth_service.dart';
import 'package:baatchet/auth/widgets/auth_helper.dart';
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
  ValueNotifier<bool> isNameEmpty = ValueNotifier(false);
  ValueNotifier<bool> isLoading = ValueNotifier(false);

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
    if (nameEditingController.text.isEmpty) {
      isNameEmpty.value = true;
    } else {
      isNameEmpty.value = false;
    }
    if (isEmailEmpty.value || isPassEmpty.value || isNameEmpty.value) {
      showStatusSnackBar(context, 'Please fill all the fields', true);
      return;
    }

    var response = await AuthService().createUserWithEmailAndPassword(
        emailEditingController.text, passEditingController.text, nameEditingController.text);

    if (response != null && response['status'] == CallStatus.succeded) {
      showStatusSnackBar(context, response['message'], false);
      Navigator.of(context).maybePop();
    } else if (response != null && response['status'] == CallStatus.failed) {
      showStatusSnackBar(context, response['message'], true);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: BoxDecoration(color: backgroundBlack),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 60),
              Image.asset('assets/Img/logo.png', height: 150),
              const SizedBox(height: 30),
              ValueListenableBuilder(
                  valueListenable: isNameEmpty,
                  builder: (context, __, ___) => getTextContainer(theme, nameEditingController, false, 'Name')),
              const SizedBox(height: 10),
              ValueListenableBuilder(
                  valueListenable: isEmailEmpty,
                  builder: (context, __, ___) => getTextContainer(theme, emailEditingController, false, 'Email')),
              const SizedBox(height: 10),
              ValueListenableBuilder(
                  valueListenable: isPassEmpty,
                  builder: (context, __, ___) => getTextContainer(theme, passEditingController, true, 'Password')),
              const SizedBox(height: 20),
              ValueListenableBuilder(
                  valueListenable: isLoading,
                  builder: (context, __, ___) {
                    return GestureDetector(
                      onTap: () => checkErrors(context),
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 60,
                        decoration:
                            BoxDecoration(color: theme.backgroundColor, borderRadius: BorderRadius.circular(12)),
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: Text('Continue', style: theme.textTheme.headline6?.copyWith(color: backgroundBlack)),
                      ),
                    );
                  }),
              const SizedBox(height: 40),
              getSocialBar(screenSize),
              const SizedBox(height: 20),
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
