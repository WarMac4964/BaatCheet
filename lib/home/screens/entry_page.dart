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
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _screens,
      items: _navBarsItems(context),
      padding: NavBarPadding.all(10),
      navBarStyle: NavBarStyle.style6,
      decoration:
          NavBarDecoration(boxShadow: [BoxShadow(color: theme.shadowColor, offset: Offset(0, -4), blurRadius: 25)]),
      confineInSafeArea: Platform.isAndroid,
      stateManagement: true,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      hideNavigationBarWhenKeyboardShows: true,
      popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
    List<PersistentBottomNavBarItem> items = [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/Img/chat_blue.svg'),
        inactiveIcon: SvgPicture.asset('assets/Img/chat_black.svg'),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/Img/call.svg', color: theme.secondaryHeaderColor),
        inactiveIcon: SvgPicture.asset('assets/Img/call.svg'),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/Img/stories.svg', color: theme.secondaryHeaderColor),
        inactiveIcon: SvgPicture.asset('assets/Img/stories.svg'),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/Img/camera.svg', color: theme.secondaryHeaderColor),
        inactiveIcon: SvgPicture.asset('assets/Img/camera.svg'),
      ),
    ];
    return items;
  }
}
