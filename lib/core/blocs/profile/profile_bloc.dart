import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_model/core/models/user.dart';
import 'package:flutter_model/core/services/api_services.dart';
import 'package:flutter_model/core/models/navigation/exceptions/exceptions.dart';
import 'package:flutter_model/core/util/util.dart';
import './bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  static const USER_PHOTO_URL =
      "https://charlotte.groupe-cyllene.com/mobile/getAvatar";

  @override
  ProfileState get initialState => InitialProfileState();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is RetrieveUserDataEvent) {
      yield ProfileLoading();
      try {
        final User user = await ApiServices.getUser();
        final String userPhoto = Uri.parse(user.avatar).pathSegments.last;
        yield ProfileUserData(
            Util.capitalize(user.name),
            Util.capitalize(user.surname),
            user.structure.name,
            USER_PHOTO_URL,
            userPhoto,
            user.id,
            user.token);
      } on ServerError {
        yield ProfileServerError();
      } on NetworkError {
        yield ProfileNetworkError();
      }
    }
  }
}
