import 'package:flutter_model/core/models/holiday_item.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MyHolidaysState {}

class InitialMyHolidaysState extends MyHolidaysState {}

class MyHolidaysLoading extends MyHolidaysState {}

class MyHolidaysNetworkError extends MyHolidaysState {}

class MyHolidaysServerError extends MyHolidaysState {}

class HolidayInfoRetrieved extends MyHolidaysState {
  final double total;
  final List<HolidayItem> listHoliday;

  HolidayInfoRetrieved(this.total, this.listHoliday);
}
