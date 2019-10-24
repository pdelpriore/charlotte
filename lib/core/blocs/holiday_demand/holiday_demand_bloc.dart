import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_model/core/models/navigation/exceptions/exceptions.dart';
import 'package:flutter_model/core/services/api_services.dart';
import 'package:flutter_model/core/util/util.dart';
import './bloc.dart';

class HolidayDemandBloc extends Bloc<HolidayDemandEvent, HolidayDemandState> {
  @override
  HolidayDemandState get initialState => InitialHolidayDemandState();

  @override
  Stream<HolidayDemandState> mapEventToState(
    HolidayDemandEvent event,
  ) async* {
    if (event is HolidayDemandDepose) {
      try {
        if (event.departureDate == null || event.duration == null) {
          yield HolidayDemandFieldError();
        } else {
          final result = await ApiServices.deposeHolidays(
              Util.formatDateEnglish(event.departureDate),
              event.duration,
              event.comment);
          if (result) {
            yield HolidayDemandDeposed(result);
          } else {
            yield HolidayDemandHolidayError();
          }
        }
      } on ServerError {
        yield HolidayDemandServerError();
      } on NetworkError {
        yield HolidayDemandNetworkError();
      }
    } else if (event is HolidayDemandCalculateReturnDate) {
      // initialize variables
      DateTime returnDate;
      final DateTime now = DateTime.now();

      // departure date selected by user
      final DateTime departureDate = event.departureDate;
      // duration selected by user
      final Duration duration = event.duration;

      // retrieve a list of holidays in France
      final List<DateTime> holidaysFrance =
          await ApiServices.getHolidaysFrance(now.year);

      // retrieve a list of next year's holidays in France
      final List<DateTime> holidaysFranceNextYear =
          await ApiServices.getHolidaysFrance(now.year + 1);

      // initialization of return date
      returnDate =
          DateTime(departureDate.year, departureDate.month, departureDate.day);
      if (duration != null) {
        // reset duration on new bloc request
        int startDuration = 0;
        while (startDuration < duration.inDays) {
          if (returnDate.weekday != DateTime.saturday &&
              returnDate.weekday != DateTime.sunday &&
              !holidaysFrance.contains(returnDate) &&
              !holidaysFranceNextYear.contains(returnDate)) {
            // increment duration only if return date is different than saturday, sunday,
            // holiday and next year's holiday
            startDuration++;
          }
          // calculate return date without weekends, holidays and next years' holidays
          returnDate = returnDate.add(Duration(days: 1));
        }
        // if return day falls on saturday, add additionally two days so return date is         // monday
        if (returnDate.weekday == DateTime.saturday) {
          returnDate = returnDate.add(Duration(days: 2));
        }
        // if return day falls on holiday, add additionally one day so return date is           // next day
        if (holidaysFrance.contains(returnDate)) {
          returnDate = returnDate.add(Duration(days: 1));
        }
        // if return day falls on holiday in next year, add additionally one day so            // return date is next day
        if (holidaysFranceNextYear.contains(returnDate)) {
          returnDate = returnDate.add(Duration(days: 1));
        }
        yield HolidayDemandReturnDateCalculated(returnDate);
      }
    }
  }
}
