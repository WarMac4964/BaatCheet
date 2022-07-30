import 'package:baatchet/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ThemeData theme;
  late Size screenSize;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack, overlays: [SystemUiOverlay.top]);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  Widget getAppBar() {
    return Container(
      width: screenSize.width,
      child: Row(children: <Widget>[
        Expanded(
            flex: 1,
            child: Container(
                alignment: Alignment.centerLeft,
                height: 40,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/Img/profilePhoto/pexels-linkedin-sales-navigator-2182970.png'),
                ))),
        Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text('BaatCheet', style: theme.textTheme.headline5),
            )),
        Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              height: 40,
              child: GestureDetector(
                onTap: () {},
                child: Icon(Icons.search, size: 30, color: theme.secondaryHeaderColor),
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
          child: Column(
            children: [
              const SizedBox(height: 22),
              getAppBar(),
              Container(
                  width: screenSize.width,
                  decoration:
                      BoxDecoration(boxShadow: [BoxShadow(blurRadius: 50, color: blackShadow, offset: Offset(0, 4))]),
                  height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 80,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(color: theme.primaryColor, borderRadius: BorderRadius.circular(10)),
                        child: ListView.builder(
                            itemCount: 5,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, int) => Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                                  padding: EdgeInsets.all(2),
                                  width: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(width: 2.5, color: theme.secondaryHeaderColor)),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/Img/profilePhoto/pexels-andrea-piacquadio-762020.png'),
                                  ),
                                )),
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        itemCount: 20,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, int) => Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.only(bottom: 10),
                          decoration:
                              BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: theme.canvasColor))),
                          height: 80,
                          width: screenSize.width - 40,
                          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                            Container(
                              height: 60,
                              width: 60,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/Img/profilePhoto/pexels-andrea-piacquadio-762020.png'),
                              ),
                            ),
                            const SizedBox(width: 25),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(height: 10),
                                  Text(
                                    'Dee Harshita',
                                    style: theme.textTheme.headline6,
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      ' Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s....',
                                      style: theme.textTheme.subtitle2,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            Container(
                              child: Column(children: <Widget>[
                                const SizedBox(height: 10),
                                Text(
                                  '10:00 PM',
                                  style: theme.textTheme.subtitle2,
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 25,
                                  width: 25,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50), color: theme.secondaryHeaderColor),
                                  child: Text('1', style: theme.textTheme.headline6),
                                )
                              ]),
                            )
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
