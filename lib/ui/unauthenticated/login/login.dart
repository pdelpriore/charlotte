import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_model/core/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_model/core/blocs/login/bloc.dart';
import 'package:flutter_model/core/blocs/login/login_bloc.dart';
import 'package:flutter_model/core/i18n.dart';
import 'package:flutter_model/ui/theme/app_icons_icons.dart';
import 'package:flutter_model/ui/theme/app_theme.dart';

import 'login_error.dart';
import 'login_form.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: BlocProvider(
          builder: (BuildContext context) => LoginBloc(
            BlocProvider.of<AuthenticationBloc>(context),
          ),
          child: LoginScreen(),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();

  _login(BuildContext context) {
    BlocProvider.of<LoginBloc>(context).dispatch(
        LogUserIn(userNameController.text, userPasswordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<LoginBloc>(context),
      builder: (BuildContext context, LoginState state) {
        Widget bottomWidget = Container();
        if (state is LoginLoading) {
          bottomWidget = CircularProgressIndicator();
        } else if (state is LoginCredentialsError) {
          bottomWidget = LoginError(
            errorText: I18n.of(context).loginError,
          );
        } else if (state is LoginNetworkError) {
          bottomWidget = LoginError(
            errorText: I18n.of(context).networkError,
          );
        } else if (state is LoginFieldError) {
          bottomWidget = LoginError(
            errorText: I18n.of(context).emptyField,
          );
        } else if (state is LoginServerError) {
          bottomWidget = LoginError(
            errorText: I18n.of(context).serverError,
          );
        }
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/imgs/big.png"), fit: BoxFit.cover),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 180.0,
                        height: 160.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/imgs/logo_charlotte.png"),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        width: 220.0,
                        height: 55.0,
                        child: LoginForm(
                          textStyle: AppTheme.of(context).loginForm,
                          controller: userNameController,
                          obscureText: false,
                          icon: AppIcons.ic_user,
                          hintText: I18n.of(context).userNameHint,
                          hintStyle: AppTheme.of(context).loginHintForm,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        width: 220.0,
                        height: 55.0,
                        child: LoginForm(
                          textStyle: AppTheme.of(context).loginForm,
                          controller: userPasswordController,
                          obscureText: true,
                          icon: AppIcons.ic_password,
                          hintText: I18n.of(context).userPasswordHint,
                          hintStyle: AppTheme.of(context).loginHintForm,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        width: 170.0,
                        height: 50.0,
                        child: RaisedButton(
                          color: AppTheme.of(context).elementActiveColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Text(
                            I18n.of(context).connectButton,
                            style: AppTheme.of(context).loginButton,
                          ),
                          onPressed: () {
                            _login(context);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      bottomWidget
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(),
              )
            ],
          ),
        );
      },
    );
  }
}
