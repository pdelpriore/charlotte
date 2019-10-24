import 'package:meta/meta.dart';

@immutable
abstract class ProfileState {}

class InitialProfileState extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileNetworkError extends ProfileState {}

class ProfileServerError extends ProfileState {}

class ProfileUserData extends ProfileState {
  final String name;
  final String surname;
  final String company;
  final String photo;
  final String id;
  final String token;
  final String userPhotoUrl;

  ProfileUserData(this.name, this.surname, this.company, this.userPhotoUrl,
      this.photo, this.id, this.token);
}
