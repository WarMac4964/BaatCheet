import 'package:flutter/material.dart';

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
