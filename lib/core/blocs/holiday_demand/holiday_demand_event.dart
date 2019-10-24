import 'package:meta/meta.dart';

@immutable
abstract class HolidayDemandEvent {}

class HolidayDemandCalculateReturnDate extends HolidayDemandEvent {
  final DateTime departureDate;
  final Duration duration;

  HolidayDemandCalculateReturnDate(this.departureDate, this.duration);
}

class HolidayDemandDepose extends HolidayDemandEvent {
  final DateTime departureDate;
  final Duration duration;
  final String comment;

  HolidayDemandDepose(this.departureDate, this.duration, this.comment);
}
