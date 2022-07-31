import 'package:flutter/material.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[],
          ),
        ),
      ),
    );
  }
}
