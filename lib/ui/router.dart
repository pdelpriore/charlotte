import 'package:flutter/material.dart';
import 'package:flutter_model/core/models/navigation/arguments/post_detail_arguments.dart';
import 'package:flutter_model/core/models/navigation/arguments/trombinoscope_detail_arguments.dart';

import 'authenticated/holiday_demand/holiday_demand.dart';
import 'authenticated/my_holidays/my_holidays.dart';
import 'authenticated/post_detail/post_detail.dart';
import 'authenticated/trombinoscope_details/trombinoscope_detail.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final dynamicArguments = routeSettings.arguments;
    switch (routeSettings.name) {
      case PostDetail.routeName:
        if (dynamicArguments is PostDetailArguments) {
          return MaterialPageRoute(builder: (BuildContext context) {
            return PostDetail(
              post: dynamicArguments.post,
            );
          });
        }
        break;
      case TrombinoscopeDetails.routeName:
        if (dynamicArguments is TrombinoscopeDetailArguments) {
          return MaterialPageRoute(
            builder: (BuildContext context) => TrombinoscopeDetails(
              name: dynamicArguments.name,
              surname: dynamicArguments.surname,
              workplace: dynamicArguments.workplace,
              company: dynamicArguments.company,
              bu: dynamicArguments.bu,
              email: dynamicArguments.email,
              phone: dynamicArguments.phone,
              photo: dynamicArguments.photo,
              photoUrl: dynamicArguments.photoUrl,
              id: dynamicArguments.id,
              token: dynamicArguments.token,
            ),
          );
        }
        break;
      case MyHolidays.routeName:
        return MaterialPageRoute(
          builder: (BuildContext context) => MyHolidays(),
        );
        break;
      case HolidayDemand.routeName:
        return MaterialPageRoute(
          builder: (BuildContext context) => HolidayDemand(),
        );
        break;
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${routeSettings.name}'),
            ),
          );
        });
    }
  }
}
