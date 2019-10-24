import 'package:get_it/get_it.dart';
import 'package:flutter_model/core/services/call_email_service.dart';

class LocatorService {
  static GetIt locator = GetIt();

  static void setUpLocator() => locator.registerSingleton(CallEmailService());
}
