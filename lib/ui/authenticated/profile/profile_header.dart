import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_model/core/i18n.dart';
import 'package:flutter_model/ui/theme/app_theme.dart';

class ProfileHeader extends StatelessWidget {
  final String userName;
  final String userSurname;
  final String userCompany;
  final String userPhotoUrl;
  final String userPhoto;
  final String userId;
  final String userToken;

  const ProfileHeader(
      {Key key,
      @required this.userName,
      @required this.userSurname,
      @required this.userCompany,
      @required this.userPhotoUrl,
      @required this.userPhoto,
      @required this.userId,
      @required this.userToken})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CachedNetworkImage(
          imageUrl:
              "${this.userPhotoUrl}/${this.userPhoto}/${this.userId}/${this.userToken}",
          imageBuilder: (context, imageProvider) => Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => Container(
            width: 120.0,
            height: 120.0,
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) =>
              Text(I18n.of(context).profileImageError),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          "${this.userName} ${this.userSurname}",
          style: AppTheme.of(context).profileUserName,
        ),
        Text(
          this.userCompany,
          style: AppTheme.of(context).profileStructureName,
        )
      ],
    );
  }
}
