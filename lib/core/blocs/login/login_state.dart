import 'package:meta/meta.dart';

@immutable
abstract class LoginState {}

class InitialLoginState extends LoginState {}

class LoginLoading extends LoginState {}

class LoginNetworkError extends LoginState {}

class LoginServerError extends LoginState {}

class LoginCredentialsError extends LoginState {}

class LoginFieldError extends LoginState {}

