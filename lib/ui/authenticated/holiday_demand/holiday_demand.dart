import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_model/core/blocs/holiday_demand/holiday_demand_bloc.dart';
import 'package:flutter_model/core/blocs/holiday_demand/holiday_demand_event.dart';
import 'package:flutter_model/core/blocs/holiday_demand/holiday_demand_state.dart';
import 'package:flutter_model/core/i18n.dart';
import 'package:flutter_model/core/util/util.dart';
import 'package:flutter_model/ui/theme/app_theme.dart';
import 'package:flutter/services.dart';

typedef TextFieldLabel = Text Function(BuildContext);

// expose state
final stateKey = GlobalKey<_HolidayDemandScreenState>();

class FormItem {
  final TextFieldLabel formFieldLabel;
  final TextEditingController formFieldController;

  FormItem(this.formFieldLabel, this.formFieldController);
}

class HolidayDemand extends StatelessWidget {
  static const String routeName = "/HolidayDemand";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: AppTheme.of(context).closeIconColor,
          ),
          onPressed: () async {
            // hide keyboard before close widget
            FocusScope.of(context).requestFocus(
              new FocusNode(),
            );
            // add a delay just to be sure that keyboard is no longer visible
            await Future.delayed(
              Duration(milliseconds: 100),
            );
            Navigator.pop(context);
            // exposed state allows to use its methods
            stateKey.currentState.clearControllers();
          },
        ),
        centerTitle: true,
        title: Text(I18n.of(context).holidayDemandTitle,
            style: AppTheme.of(context).myHolidaysBarTitle),
      ),
      body: SafeArea(
        child: BlocProvider(
          builder: (BuildContext context) => HolidayDemandBloc(),
          child: HolidayDemandScreen(),
        ),
      ),
    );
  }
}

class HolidayDemandScreen extends StatefulWidget {
  // passing new key (our exposed state)
  HolidayDemandScreen({Key key}) : super(key: stateKey);

  @override
  _HolidayDemandScreenState createState() => _HolidayDemandScreenState();
}

class _HolidayDemandScreenState extends State<HolidayDemandScreen> {
  static TextEditingController departureDateController =
      TextEditingController();
  static TextEditingController returnDateController = TextEditingController();
  static TextEditingController durationController = TextEditingController();
  static TextEditingController commentsController = TextEditingController();
  Duration duration;
  DateTime departureDateTime;
  List<FormItem> formItemList = [
    FormItem(
        (context) => Text(
              I18n.of(context).departureDate,
              style: AppTheme.of(context).holidayDemandFieldLabel,
            ),
        departureDateController),
    FormItem(
        (context) => Text(
              I18n.of(context).returnDate,
              style: AppTheme.of(context).holidayDemandFieldLabel,
            ),
        returnDateController),
    FormItem(
        (context) => Text(
              I18n.of(context).duration,
              style: AppTheme.of(context).holidayDemandFieldLabel,
            ),
        durationController),
    FormItem(
        (context) => Text(
              I18n.of(context).comments,
              style: AppTheme.of(context).holidayDemandFieldLabel,
            ),
        commentsController)
  ];

  _calculateReturnDate(BuildContext context) {
    BlocProvider.of<HolidayDemandBloc>(context).dispatch(
      HolidayDemandCalculateReturnDate(departureDateTime, duration),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: clearControllers,
      child: BlocListener<HolidayDemandEvent, HolidayDemandState>(
        bloc: BlocProvider.of<HolidayDemandBloc>(context),
        listener: (BuildContext context, HolidayDemandState state) {
          if (state is HolidayDemandReturnDateCalculated) {
            DateTime returnDate = state.returnDate;
            returnDateController.text = Util.formatDate(
              returnDate.toString(),
            );
          } else if (state is HolidayDemandDeposed) {
            // if holiday request saved successfully, close this page and pass some data           // to my holiday page
            if (state.response) {
              clearControllers();
              Navigator.of(context).pop();
            }
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (FormItem formItem in formItemList)
                  makeHolidayDemandForm(context, formItem),
                SizedBox(height: 50.0),
                Center(
                  child: Container(
                    width: 200.0,
                    height: 50.0,
                    child: RaisedButton(
                      color: AppTheme.of(context).elementActiveColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: Text(
                        I18n.of(context).saveButton,
                        style: AppTheme.of(context).loginButton,
                      ),
                      onPressed: () =>
                          BlocProvider.of<HolidayDemandBloc>(context).dispatch(
                        HolidayDemandDepose(departureDateTime, duration,
                            commentsController.text),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: BlocBuilder(
                    bloc: BlocProvider.of<HolidayDemandBloc>(context),
                    builder: (BuildContext context, HolidayDemandState state) {
                      if (state is HolidayDemandNetworkError) {
                        return Text(
                          I18n.of(context).networkError,
                          style: AppTheme.of(context).loginError,
                        );
                      } else if (state is HolidayDemandFieldError) {
                        return Text(
                          I18n.of(context).emptyField,
                          style: AppTheme.of(context).loginError,
                        );
                      } else if (state is HolidayDemandServerError) {
                        return Text(
                          I18n.of(context).serverError,
                          style: AppTheme.of(context).loginError,
                        );
                      } else if (state is HolidayDemandHolidayError) {
                        return Text(
                          I18n.of(context).holidayError,
                          style: AppTheme.of(context).loginError,
                        );
                      }
                      return Container();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> selectDepartureDate(
      BuildContext context, TextEditingController departureDate) async {
    DateTime now = DateTime.now();
    // hide keyboard before showing date picker
    FocusScope.of(context).requestFocus(
      new FocusNode(),
    );
    // add a delay just to be sure that keyboard is no longer visible
    await Future.delayed(
      Duration(milliseconds: 100),
    );

    DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(now.year),
        lastDate: DateTime(now.year + 2));
    if (pickedDate != null) {
      // user cannot take a holiday before today
      if (pickedDate.isBefore(now)) {
        // variable prepared for bloc treatment
        setState(() => this.departureDateTime = now);
        // variable prepared for widget display
        departureDate.text = Util.formatDate(
          now.toString(),
        );
      } else {
        // variable prepared for bloc treatment
        setState(() => this.departureDateTime = pickedDate);
        // variable prepared for widget display
        departureDate.text = Util.formatDate(
          pickedDate.toString(),
        );
      }
    }
    _calculateReturnDate(context);
  }

  Widget makeHolidayDemandForm(BuildContext context, FormItem item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            item.formFieldLabel(context),
            TextField(
              onChanged: item.formFieldController == durationController
                  ? (value) {
                      setState(
                        () => this.duration = Duration(
                          days: double.parse(value).round(),
                        ),
                      );
                      _calculateReturnDate(context);
                    }
                  : null,
              onTap: item.formFieldController == departureDateController
                  ? () => selectDepartureDate(context, departureDateController)
                  : null,
              keyboardType: item.formFieldController == durationController
                  ? TextInputType.number
                  : TextInputType.text,
              maxLines:
                  item.formFieldController == commentsController ? 3 : null,
              maxLength:
                  item.formFieldController == commentsController ? 120 : null,
              controller: item.formFieldController,
              focusNode: item.formFieldController == returnDateController
                  ? DeactivateKeyboardFocusNode()
                  : null,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: AppTheme.of(context).elementActiveColor),
                ),
              ),
              inputFormatters: item.formFieldController == durationController
                  ? [
                      WhitelistingTextInputFormatter(
                        RegExp(r"^\d{1,2}(\.)?5?$"),
                      )
                    ]
                  : null,
              enableInteractiveSelection: false,
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> clearControllers() async {
    setState(() {
      departureDateController.clear();
      returnDateController.clear();
      durationController.clear();
      commentsController.clear();
    });
    return true;
  }
}
