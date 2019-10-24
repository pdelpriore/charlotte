import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_model/core/blocs/holiday_demand/holiday_demand_bloc.dart';
import 'package:flutter_model/core/blocs/holiday_demand/holiday_demand_event.dart';
import 'package:flutter_model/core/blocs/holiday_demand/holiday_demand_state.dart';
import 'package:flutter_model/core/blocs/my_holidays/my_holidays_bloc.dart';
import 'package:flutter_model/core/blocs/my_holidays/my_holidays_event.dart';
import 'package:flutter_model/core/blocs/my_holidays/my_holidays_state.dart';
import 'package:flutter_model/core/i18n.dart';
import 'package:flutter_model/core/models/holiday_item.dart';
import 'package:flutter_model/ui/authenticated/holiday_demand/holiday_demand.dart';
import 'package:flutter_model/ui/shared/network_error.dart';
import 'package:flutter_model/ui/shared/server_error.dart';
import 'package:flutter_model/ui/theme/app_theme.dart';
import 'package:toast/toast.dart';

import 'holiday_row.dart';

class MyHolidays extends StatelessWidget {
  static const String routeName = "/MyHolidays";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(I18n.of(context).myHolidaysBarTitle,
            style: AppTheme.of(context).myHolidaysBarTitle),
      ),
      body: SafeArea(
        child: BlocProvider(
          builder: (BuildContext context) => MyHolidaysBloc()
            ..dispatch(
              RetrieveHolidayInfo(),
            ),
          child: MyHolidaysScreen(),
        ),
      ),
    );
  }
}

class MyHolidaysScreen extends StatelessWidget {
  _navigateToHolidayDemand(BuildContext context) {
    Navigator.of(context).pushNamed(HolidayDemand.routeName);

    BlocProvider.of<MyHolidaysBloc>(context).dispatch(
      RetrieveHolidayInfo(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HolidayDemandEvent, HolidayDemandState>(
      bloc: BlocProvider.of<HolidayDemandBloc>(context),
      listener: (BuildContext context, HolidayDemandState state) {
        if (state is HolidayDemandDeposed) {
          if (state.response) {
            Toast.show(I18n.of(context).holidayDeposedMessage, context,
                duration: Toast.LENGTH_SHORT,
                gravity: Toast.BOTTOM,
                textColor: AppTheme.of(context).toastTextColor,
                backgroundColor: AppTheme.of(context).toastBackgroundColor);
          }
        }
      },
      child: BlocBuilder(
          bloc: BlocProvider.of<MyHolidaysBloc>(context),
          builder: (BuildContext context, MyHolidaysState state) {
            if (state is MyHolidaysLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MyHolidaysNetworkError) {
              return NetworkError();
            } else if (state is MyHolidaysServerError) {
              return ServerError();
            } else if (state is HolidayInfoRetrieved) {
              final double total = state.total;
              final List<HolidayItem> listHoliday = state.listHoliday;
              return Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 30.0,
                            ),
                            Text(
                              total.toString(),
                              style: AppTheme.of(context)
                                  .holidaysNumberOfAvailableDays,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              I18n.of(context).holidayAvailableDays,
                              style: AppTheme.of(context)
                                  .holidaysAvailableDaysTitle,
                            ),
                            SizedBox(
                              height: 26.0,
                            ),
                            Container(
                              width: 200.0,
                              height: 50.0,
                              child: RaisedButton(
                                color: AppTheme.of(context).elementActiveColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: Text(
                                  I18n.of(context).holidayDemandButton,
                                  style: AppTheme.of(context)
                                      .newHolidayDemandButton,
                                ),
                                onPressed: () =>
                                    _navigateToHolidayDemand(context),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.white,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: listHoliday.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 35.0,
                                  ),
                                  HolidayRow(
                                    item: state.listHoliday[index],
                                  )
                                ],
                              );
                            }),
                      ),
                    )
                  ],
                ),
              );
            }
            return Container();
          }),
    );
  }
}
