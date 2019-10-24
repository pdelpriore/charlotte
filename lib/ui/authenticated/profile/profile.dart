import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_model/core/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_model/core/blocs/authentication/authentication_event.dart';
import 'package:flutter_model/core/blocs/profile/profile_bloc.dart';
import 'package:flutter_model/core/blocs/profile/profile_event.dart';
import 'package:flutter_model/core/blocs/profile/profile_state.dart';
import 'package:flutter_model/ui/authenticated/my_holidays/my_holidays.dart';
import 'package:flutter_model/ui/authenticated/profile/profile_button.dart';
import 'package:flutter_model/ui/authenticated/profile/profile_header.dart';
import 'package:flutter_model/ui/shared/network_error.dart';
import 'package:flutter_model/ui/shared/server_error.dart';
import 'package:flutter_model/ui/theme/app_icons_icons.dart';
import 'package:flutter_model/ui/theme/app_theme.dart';
import 'package:flutter_model/core/i18n.dart';

class Profile extends StatelessWidget {
  _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(I18n.of(context).logoutConfirm),
        actions: <Widget>[
          FlatButton(
              child: Text(I18n.of(context).yesButton),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).dispatch(
                  LogOutEvent(),
                );
                Navigator.pop(context);
              }),
          FlatButton(
            child: Text(I18n.of(context).noButton),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> choices = [I18n.of(context).profileDisconnect];
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: AppTheme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.of(context).backgroundColor,
        elevation: 0,
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onSelected: (String choice) => _logout(context),
            itemBuilder: (BuildContext context) {
              return choices
                  .map(
                    (choice) => PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    ),
                  )
                  .toList();
            },
          )
        ],
      ),
      body: SafeArea(
        child: BlocProvider(
          builder: (BuildContext context) => ProfileBloc()
            ..dispatch(
              RetrieveUserDataEvent(),
            ),
          child: ProfileScreen(),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<ProfileBloc>(context),
      builder: (BuildContext context, ProfileState state) {
        Widget profileHeader = Column();
        if (state is ProfileLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProfileNetworkError) {
          return NetworkError();
        } else if (state is ProfileServerError) {
          return ServerError();
        } else if (state is ProfileUserData) {
          profileHeader = ProfileHeader(
            userName: state.name,
            userSurname: state.surname,
            userCompany: state.company,
            userPhotoUrl: state.userPhotoUrl,
            userPhoto: state.photo,
            userId: state.id,
            userToken: state.token,
          );

          return Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Center(child: profileHeader),
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        ProfileButton(
                          route: null,
                          buttonIcon: AppIcons.ic_ic_info,
                          buttonTitle: I18n.of(context).myInformations,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        ProfileButton(
                          route: MyHolidays.routeName,
                          buttonIcon: AppIcons.ic_ic_holidays,
                          buttonTitle: I18n.of(context).myHolidays,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        ProfileButton(
                          route: null,
                          buttonIcon: AppIcons.ic_ic_project,
                          buttonTitle: I18n.of(context).myProjects,
                        ),
                      ],
                    )),
                Expanded(
                  flex: 1,
                  child: Container(),
                )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
