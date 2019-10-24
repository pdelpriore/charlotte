import 'package:flutter/material.dart';
import 'package:flutter_model/ui/theme/app_icons_icons.dart';
import 'package:flutter_model/ui/theme/app_theme.dart';

class ProfileButton extends StatelessWidget {
  final String route;
  final IconData buttonIcon;
  final String buttonTitle;

  const ProfileButton(
      {Key key,
      @required this.route,
      @required this.buttonIcon,
      @required this.buttonTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: 55.0,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Material(
          child: InkWell(
            onTap: this.route == null
                ? () {}
                : () => Navigator.pushNamed(
                      context,
                      this.route,
                    ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 11.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Icon(
                      this.buttonIcon,
                      color: AppTheme.of(context).elementActiveColor,
                      size: 15.0,
                    ),
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                        color: AppTheme.of(context).iconBackgroundColor,
                        shape: BoxShape.circle),
                    foregroundDecoration: this.route != null
                        ? null
                        : BoxDecoration(
                            color: Colors.grey,
                            backgroundBlendMode: BlendMode.saturation),
                  ),
                  Text(
                    this.buttonTitle,
                    style: AppTheme.of(context).profileMenuText,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 11.0),
                    child: Icon(
                      AppIcons.ic_ic_arrow,
                      size: 15.0,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
