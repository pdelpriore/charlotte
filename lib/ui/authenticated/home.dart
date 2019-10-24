import 'package:flutter/material.dart';
import 'package:flutter_model/ui/authenticated/profile/profile.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_model/ui/authenticated/time_tracking/time_tracking.dart';
import 'package:flutter_model/ui/authenticated/trombinoscope/trombinoscope.dart';
import 'package:flutter_model/ui/theme/app_icons_icons.dart';
import 'package:flutter_model/ui/theme/app_theme.dart';
import 'meeting/meeting.dart';
import 'my_charges/my_charges.dart';
import 'package:flutter_model/core/i18n.dart';

typedef TextTitle = Text Function(BuildContext);

class BottomBarItem {
  final IconData barIcon;
  final TextTitle barTitle;
  final String barPicture;

  BottomBarItem(this.barIcon, this.barTitle, this.barPicture);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 4;
  List<BottomBarItem> barList = [
    BottomBarItem(
        AppIcons.ic_ic_clock,
        (context) => Text(I18n.of(context).timeTracking,
            style: AppTheme.of(context).homeLabelStyle),
        null),
    BottomBarItem(
        AppIcons.ic_ic_wallet,
        (context) => Text(I18n.of(context).myCharges,
            style: AppTheme.of(context).homeLabelStyle),
        null),
    BottomBarItem(
        null,
        (context) => Text(I18n.of(context).meeting,
            style: AppTheme.of(context).homeLabelStyle),
        "assets/icons/ic_ic_meeting.svg"),
    BottomBarItem(
        AppIcons.ic_ic_trombi,
        (context) => Text(I18n.of(context).trombinoscope,
            style: AppTheme.of(context).homeLabelStyle),
        null),
    BottomBarItem(
        AppIcons.ic_ic_profil_selected,
        (context) => Text(I18n.of(context).profile,
            style: AppTheme.of(context).homeLabelStyle),
        null),
  ];

  final List<Widget> tabs = [
    TimeTracking(),
    MyCharges(),
    Meeting(),
    Trombinoscope(),
    Profile()
  ];

  _onBottomBarSwitch(int _newIndex) {
    setState(() {
      this._index = _newIndex == 3 || _newIndex == 4 ? _newIndex : 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppTheme.of(context).elementActiveColor,
        unselectedItemColor: AppTheme.of(context).elementInactiveColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        items: barList.map((item) => makeBarItem(context, item)).toList(),
        onTap: (index) => _onBottomBarSwitch(index),
      ),
    );
  }

  BottomNavigationBarItem makeBarItem(
      BuildContext context, BottomBarItem item) {
    return BottomNavigationBarItem(
      icon: item.barPicture == null
          ? Icon(
              item.barIcon,
            )
          : SvgPicture.asset(item.barPicture,
              alignment: Alignment.center, allowDrawingOutsideViewBox: false),
      title: item.barTitle(context),
    );
  }
}
