import 'package:flutter/material.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  late ThemeData theme;
  late Size screenSize;

  Widget getAppBar() {
    return Container(
      width: screenSize.width,
      child: Row(children: <Widget>[
        Expanded(flex: 1, child: Container()),
        Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text('Stories', style: theme.textTheme.headline5),
            )),
        Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              height: 40,
              child: GestureDetector(
                onTap: () {},
                child: Icon(Icons.add, size: 30, color: theme.secondaryHeaderColor),
              ),
            ))
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: screenSize.height,
        width: screenSize.width,
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
          const SizedBox(height: 22),
          getAppBar(),
          GridView.builder(
              itemCount: 10,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 10),
              itemBuilder: (context, index) => Container(
                    height: 100,
                    width: 100,
                  ))
        ])),
      ),
    );
  }
}
