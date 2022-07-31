import 'dart:io';

import 'package:baatchet/auth/auth_service.dart';
import 'package:baatchet/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

void showStatusSnackBar(BuildContext context, String content, bool isError) {
  ThemeData theme = Theme.of(context);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.transparent,
    content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isError ? theme.errorColor : theme.primaryColor,
        ),
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10),
        child: Text(content,
            style: isError
                ? theme.textTheme.bodyText2?.copyWith(color: theme.backgroundColor)
                : theme.textTheme.bodyText2)),
  ));
}

Widget getSocialBar(Size screenSize) {
  bool platformIosCheck = Platform.isIOS;
  return Row(
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
  );
}
