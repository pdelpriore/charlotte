import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_model/core/models/navigation/exceptions/exceptions.dart';
import 'package:flutter_model/core/models/trombinoscope.dart';
import 'package:flutter_model/core/services/api_services.dart';
import 'package:flutter_model/core/util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './bloc.dart';

class TrombinoscopeBloc extends Bloc<TrombinoscopeEvent, TrombinoscopeState> {
  static const USER_TOKEN = "userToken";
  static const USER_ID = "userId";
  static const USER_PHOTO_URL =
      "https://charlotte.groupe-cyllene.com/mobile/getAvatar";

  Trombinoscope trombinoscope;
  SharedPreferences prefs;

  @override
  TrombinoscopeState get initialState => InitialTrombinoscopeState();

  @override
  Stream<TrombinoscopeState> mapEventToState(
    TrombinoscopeEvent event,
  ) async* {
    if (event is RetrievePeopleList) {
      yield TrombinoscopeLoading();
      try {
        trombinoscope = await ApiServices.getTrombinoscope();
        prefs = await SharedPreferences.getInstance();
        yield TrombinoscopePeopleRetrieved(trombinoscope.people, USER_PHOTO_URL,
            prefs.get(USER_ID), prefs.get(USER_TOKEN));
      } on ServerError {
        yield TrombinoscopeServerError();
      } on NetworkError {
        yield TrombinoscopeNetworkError();
      }
    } else if (event is SearchPerson) {
      if (event.query.isNotEmpty) {
        yield TrombinoscopePeopleRetrieved(
            trombinoscope.people
                .where((user) =>
                    (("${user.name} ${Util.capitalize(user.surname)}")
                        .contains(Util.capitalize(event.query))) ||
                    ("${Util.capitalize(user.surname)} ${user.name}")
                        .contains(Util.capitalize(event.query)) ||
                    (Util.capitalize(user.structure.name))
                        .contains(Util.capitalize(event.query)))
                .toList(),
            USER_PHOTO_URL,
            prefs.get(USER_ID),
            prefs.get(USER_TOKEN));
      } else {
        yield TrombinoscopePeopleRetrieved(trombinoscope.people, USER_PHOTO_URL,
            prefs.get(USER_ID), prefs.get(USER_TOKEN));
      }
    }
  }
}
