import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_model/core/models/navigation/exceptions/exceptions.dart';
import 'package:flutter_model/core/models/user_holidays.dart';
import 'package:flutter_model/core/services/api_services.dart';
import './bloc.dart';

class MyHolidaysBloc extends Bloc<MyHolidaysEvent, MyHolidaysState> {
  @override
  MyHolidaysState get initialState => InitialMyHolidaysState();

  @override
  Stream<MyHolidaysState> mapEventToState(
    MyHolidaysEvent event,
  ) async* {
    if (event is RetrieveHolidayInfo) {
      yield MyHolidaysLoading();
      try {
        final UserHolidays userHolidays = await ApiServices.getUserHolidays();
        yield HolidayInfoRetrieved(
            double.parse(userHolidays.holidays.total.toStringAsFixed(2)),
            userHolidays.holidays.holidayItems);
      } on ServerError {
        yield MyHolidaysServerError();
      } on NetworkError {
        yield MyHolidaysNetworkError();
      }
    }
  }
}
