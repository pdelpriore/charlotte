import 'package:meta/meta.dart';

@immutable
abstract class TrombinoscopeEvent {}

class RetrievePeopleList extends TrombinoscopeEvent {}

class SearchPerson extends TrombinoscopeEvent {
  final String query;

  SearchPerson(this.query);
}


