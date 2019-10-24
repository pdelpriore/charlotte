import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppTheme extends InheritedWidget {
  AppTheme({
    @required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static AppTheme of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppTheme);
  }

  //**************************************************************************
  //TextStyles :

  get title => TextStyle();

  get subtitle => TextStyle();

  get subhead => TextStyle();

  get overline => TextStyle();

  get headline => TextStyle();

  get display1 =>
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18);

  get display2 => TextStyle(color: Colors.grey, fontSize: 14);

  get display3 => TextStyle();

  get loginHintForm => TextStyle(fontSize: 16.0, color: Colors.white);

  get loginForm => TextStyle(color: Colors.white);

  get loginError => TextStyle(color: Colors.red);

  get loginButton => TextStyle(
      fontSize: 18.0,
      color: Colors.white,
      fontFamily: "RobotoRegular",
      fontWeight: FontWeight.w400);

  get newHolidayDemandButton => TextStyle(
      fontSize: 16.0, color: Colors.white, fontFamily: "RobotoRegular");

  get profileMenuText => TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold);

  get profileUserName => TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  get profileStructureName => TextStyle(fontSize: 12.0);

  get trombiUserName => TextStyle(
        fontFamily: "RobotoBold",
        fontWeight: FontWeight.w700,
        fontSize: 15.0,
        color: Color(0xff4a4a4a),
      );

  get trombiUserWorkplace => TextStyle(
        fontFamily: "RobotoRegular",
        fontWeight: FontWeight.w400,
        fontSize: 13.0,
        color: Color(0xff4a4a4a),
      );

  get trombiUserBu => TextStyle(
        fontFamily: "RobotoRegular",
        fontWeight: FontWeight.w400,
        fontSize: 13.0,
        color: Color(0xff4a4a4a),
      );

  get trombiUserMail => TextStyle(
        fontFamily: "RobotoRegular",
        fontWeight: FontWeight.w400,
        fontSize: 13.0,
        decoration: TextDecoration.underline,
        color: Color(0xff4259e7),
      );

  get trombiUserTel => TextStyle(
        fontFamily: "RobotoRegular",
        fontWeight: FontWeight.w400,
        fontSize: 13.0,
        color: Color(0xff4259e7),
      );

  get myHolidaysBarTitle => TextStyle(
      fontFamily: "RobotoBold",
      fontWeight: FontWeight.w700,
      fontSize: 15.0,
      color: Colors.black);

  get holidaysAvailableDaysTitle => TextStyle(
      fontFamily: "RobotoRegular",
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
      color: Color(0xff4a4a4a));

  get holidaysNumberOfAvailableDays => TextStyle(
      fontFamily: "RobotoBold",
      fontWeight: FontWeight.w700,
      fontSize: 34.0,
      color: Color(0xff4a4a4a));

  get holidayList => TextStyle(
      fontFamily: "RobotoRegular",
      fontWeight: FontWeight.w400,
      fontSize: 16.0,
      color: Color(0xff8a000000));

  get holidayDemandFieldLabel => TextStyle(
      fontFamily: "RobotoRegular",
      fontWeight: FontWeight.w400,
      fontSize: 12.0,
      color: Color(0xff61000000));

  get homeLabelStyle => TextStyle(fontSize: 11.0);

  get holidayItemInProgressStyle => TextStyle(
      fontFamily: "RobotoRegular",
      fontWeight: FontWeight.w400,
      fontSize: 16.0,
      color: inProgressColor
  );

  get holidayItemOkStyle => TextStyle(
      fontFamily: "RobotoRegular",
      fontWeight: FontWeight.w400,
      fontSize: 16.0,
      color: okColor
  );

  get holidayItemRejectedStyle => TextStyle(
      fontFamily: "RobotoRegular",
      fontWeight: FontWeight.w400,
      fontSize: 16.0,
      color: rejectedColor
  );

  get display4 => TextStyle();

  get body1 => TextStyle();

  get body2 => TextStyle();

  get caption => TextStyle();

  get button => TextStyle();

  //**************************************************************************
  //Colors :

  get elementActiveColor => Color(0xff4259e7);

  get elementInactiveColor => Color(0xff8e8e93);

  get backgroundColor => Color(0xffeef1f5);

  get iconBackgroundColor => Color(0xfff9f9f9);

  get closeIconColor => Color(0xffcbc9d5);

  get inProgressColor => Color(0xfff5a623);

  get okColor => Color(0xff7ed321);

  get rejectedColor => Color(0xffd0021b);

  get toastTextColor => Color(0xff4a4a4a);

  get toastBackgroundColor => Color(0xfff2f2f2);

}
