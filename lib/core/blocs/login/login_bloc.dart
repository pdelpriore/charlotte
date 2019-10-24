import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_model/core/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_model/core/blocs/authentication/authentication_event.dart';
import 'package:flutter_model/core/models/navigation/exceptions/exceptions.dart';
import 'package:flutter_model/core/models/user.dart';
import 'package:flutter_model/core/services/api_services.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc _authenticationBloc;

  LoginBloc(this._authenticationBloc);

  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LogUserIn) {
      yield LoginLoading();
      try {
        if (event.userName.isEmpty || event.password.isEmpty) {
          yield LoginFieldError();
        } else {
          final User user =
              await ApiServices.login(event.userName, event.password);
          await ApiServices.persistToken(user.token, user.id);
          _authenticationBloc.dispatch(LoggedInEvent());
        }
      } on BadCredentialsError {
        yield LoginCredentialsError();
      } on ServerError {
        yield LoginServerError();
      } on NetworkError {
        yield LoginNetworkError();
      }
    }
  }
}
