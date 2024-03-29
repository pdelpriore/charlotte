import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_model/core/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_model/core/blocs/favorites/bloc.dart';
import 'package:flutter_model/core/i18n.dart';
import 'package:flutter_model/ui/authentication.dart';
import 'package:flutter_model/ui/router.dart';
import 'package:flutter_model/ui/theme/app_theme.dart';
import 'package:flutter/services.dart';
import 'core/blocs/holiday_demand/holiday_demand_bloc.dart';
import 'core/services/locator_service.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    BlocSupervisor.delegate = SimpleBlocDelegate();
    runApp(MyApp());
    LocatorService.setUpLocator();
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<FavoritesBloc>(
            builder: (BuildContext context) => FavoritesBloc(),
          ),
          BlocProvider<AuthenticationBloc>(
            builder: (BuildContext context) => AuthenticationBloc(),
          ),
          BlocProvider<HolidayDemandBloc>(
            builder: (BuildContext context) => HolidayDemandBloc(),
          )
        ],
        child: AppTheme(
          child: MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: TextTheme(
                display1: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                display2: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            localizationsDelegates: [
              const I18nDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', ''),
              const Locale('fr', ''),
            ],
            onGenerateRoute: Router.generateRoute,
            home: Authentication(),
          ),
        ));
  }
}
