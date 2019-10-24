import 'package:url_launcher/url_launcher.dart';

class CallEmailService {
  void call(String number) => launch("tel:$number");

  void sendEmail(String email) => launch("mailto:$email");
}
