import 'package:meta/meta.dart';

@immutable
abstract class HolidayDemandState {}

class InitialHolidayDemandState extends HolidayDemandState {}

class HolidayDemandNetworkError extends HolidayDemandState {}

class HolidayDemandFieldError extends HolidayDemandState {}

class HolidayDemandServerError extends HolidayDemandState {}

class HolidayDemandHolidayError extends HolidayDemandState {}

class HolidayDemandReturnDateCalculated extends HolidayDemandState {
  final DateTime returnDate;

  HolidayDemandReturnDateCalculated(this.returnDate);
}

class HolidayDemandDeposed extends HolidayDemandState {
  final bool response;

  HolidayDemandDeposed(this.response);
}
