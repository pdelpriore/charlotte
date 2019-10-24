import 'package:flutter/material.dart';
import 'package:flutter_model/core/i18n.dart';
import 'package:flutter_model/core/models/holiday_item.dart';
import 'package:flutter_model/core/util/util.dart';
import 'package:flutter_model/ui/theme/app_theme.dart';

class HolidayRow extends StatelessWidget {
  final HolidayItem item;

  const HolidayRow({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              Util.formatDate(item.date),
              style: AppTheme.of(context).holidayList,
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              item.duration,
              style: AppTheme.of(context).holidayList,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: getHolidayStatus(item.status, context),
          )
        ],
      ),
    );
  }

  Text getHolidayStatus(String status, BuildContext context) {
    String text;
    TextStyle textStyle;
    switch (status) {
      case "0":
        text = I18n.of(context).inProgress;
        textStyle = AppTheme.of(context).holidayItemInProgressStyle;
        break;
      case "1":
        text = I18n.of(context).ok;
        textStyle = AppTheme.of(context).holidayItemOkStyle;
        break;
      case "2":
        text = I18n.of(context).rejected;
        textStyle = AppTheme.of(context).holidayItemRejectedStyle;
        break;
    }
    return Text(
      text,
      style: textStyle,
      textAlign: TextAlign.end,
    );
  }
}
