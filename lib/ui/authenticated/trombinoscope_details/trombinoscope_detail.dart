import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_model/core/services/call_email_service.dart';
import 'package:flutter_model/core/services/locator_service.dart';
import 'package:flutter_model/ui/theme/app_theme.dart';

class TrombinoscopeDetails extends StatelessWidget {
  final CallEmailService service = LocatorService.locator<CallEmailService>();
  static const String routeName = "/TrombinoscopeDetails";

  final String name;
  final String surname;
  final String workplace;
  final String company;
  final String bu;
  final String email;
  final String phone;
  final String photo;
  final String photoUrl;
  final String id;
  final String token;

  TrombinoscopeDetails(
      {Key key,
      @required this.name,
      this.surname,
      this.workplace,
      this.company,
      this.bu,
      this.email,
      this.phone,
      this.photo,
      this.photoUrl,
      this.id,
      this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: AppTheme.of(context).closeIconColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                CachedNetworkImage(
                  imageUrl: "$photoUrl/$photo/$id/$token",
                  imageBuilder: (context, imageProvider) => Container(
                    width: 160.0,
                    height: 160.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 22.0),
                Container(
                    child: Center(
                  child: Column(
                    children: <Widget>[
                      Text("$name $surname",
                          style: AppTheme.of(context).trombiUserName),
                      SizedBox(height: 15.0),
                      Text("$workplace $company",
                          style: AppTheme.of(context).trombiUserWorkplace),
                      SizedBox(height: 15.0),
                      Text(bu, style: AppTheme.of(context).trombiUserBu),
                      SizedBox(height: 15.0),
                      InkWell(
                        onTap: () => service.sendEmail(email),
                        child: Text(email,
                            style: AppTheme.of(context).trombiUserMail),
                      ),
                      SizedBox(height: 15.0),
                      InkWell(
                        onTap: phone.startsWith("0") && phone.length > 1
                            ? () => service.call(phone)
                            : () {},
                        child: Text(phone,
                            style: AppTheme.of(context).trombiUserTel),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
