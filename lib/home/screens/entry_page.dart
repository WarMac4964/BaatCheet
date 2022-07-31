import 'dart:io';

import 'package:baatchet/call/call_screen.dart';
import 'package:baatchet/camera/camera_screen.dart';
import 'package:baatchet/home/screens/home_screen.dart';
import 'package:baatchet/status/status_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class EntryPage extends StatefulWidget {
  EntryPage({Key? key}) : super(key: key);

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  late PersistentTabController _controller;
  Widget homeWidget = HomeScreen();
  Widget callWidget = CallScreen();
  Widget statusWidget = StatusScreen();
  Widget cameraWidget = CameraScreen();
  late List<Widget> _screens;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    _screens = [homeWidget, callWidget, statusWidget, cameraWidget];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    _controller = PersistentTabController(initialIndex: 0);
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _screens,
        backgroundColor: theme.scaffoldBackgroundColor,
        items: _navBarsItems(context),
        padding: NavBarPadding.all(10),
        navBarStyle: NavBarStyle.style6,
        resizeToAvoidBottomInset: true,
        popAllScreensOnTapOfSelectedTab: true,
        decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10),
            colorBehindNavBar: theme.backgroundColor,
            boxShadow: [BoxShadow(color: theme.shadowColor, offset: Offset(0, -4), blurRadius: 25)]),
        confineInSafeArea: Platform.isAndroid,
        margin: EdgeInsets.only(bottom: 20, left: 15, right: 15),
        handleAndroidBackButtonPress: true,
        hideNavigationBarWhenKeyboardShows: true,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeIn,
        ),
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
    List<PersistentBottomNavBarItem> items = [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/Img/chat_blue.svg', color: theme.primaryColor),
        inactiveIcon: SvgPicture.asset('assets/Img/chat_black.svg', color: theme.dividerColor),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/Img/call.svg', color: theme.primaryColor),
        inactiveIcon: SvgPicture.asset('assets/Img/call.svg', color: theme.dividerColor),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/Img/stories.svg', color: theme.primaryColor),
        inactiveIcon: SvgPicture.asset('assets/Img/stories.svg', color: theme.dividerColor),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/Img/camera.svg', color: theme.primaryColor),
        inactiveIcon: SvgPicture.asset('assets/Img/camera.svg', color: theme.dividerColor),
      ),
    ];
    return items;
  }
}
