import 'package:meta/meta.dart';

@immutable
abstract class ProfileEvent {}

class RetrieveUserDataEvent extends ProfileEvent {}
