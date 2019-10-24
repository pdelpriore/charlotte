import 'package:flutter_model/core/models/people.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TrombinoscopeState {}

class InitialTrombinoscopeState extends TrombinoscopeState {}

class TrombinoscopeLoading extends TrombinoscopeState {}

class TrombinoscopeNetworkError extends TrombinoscopeState {}

class TrombinoscopeServerError extends TrombinoscopeState {}

class TrombinoscopePeopleRetrieved extends TrombinoscopeState {
  final List<People> listPeople;
  final String photoUrl;
  final String id;
  final String token;

  TrombinoscopePeopleRetrieved(
      this.listPeople, this.photoUrl, this.id, this.token);
}
