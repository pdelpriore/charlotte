import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_model/core/blocs/trombinoscope/trombinoscope_bloc.dart';
import 'package:flutter_model/core/blocs/trombinoscope/trombinoscope_state.dart';
import 'package:flutter_model/core/blocs/trombinoscope/trombinoscope_event.dart';
import 'package:flutter_model/core/i18n.dart';
import 'package:flutter_model/core/models/navigation/arguments/trombinoscope_detail_arguments.dart';
import 'package:flutter_model/core/models/people.dart';
import 'package:flutter_model/core/util/util.dart';
import 'package:flutter_model/ui/authenticated/trombinoscope_details/trombinoscope_detail.dart';
import 'package:flutter_model/ui/shared/network_error.dart';
import 'package:flutter_model/ui/shared/server_error.dart';
import 'package:flutter_model/ui/theme/app_theme.dart';

class Trombinoscope extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).backgroundColor,
      body: SafeArea(
        child: BlocProvider(
          builder: (BuildContext context) => TrombinoscopeBloc()
            ..dispatch(
              RetrievePeopleList(),
            ),
          child: TrombinoscopeScreen(),
        ),
      ),
    );
  }
}

class TrombinoscopeScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  _searchPerson(String query, BuildContext context) {
    BlocProvider.of<TrombinoscopeBloc>(context).dispatch(
      SearchPerson(searchController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<TrombinoscopeBloc>(context),
      builder: (BuildContext context, TrombinoscopeState state) {
        if (state is TrombinoscopeLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TrombinoscopeNetworkError) {
          return NetworkError();
        } else if (state is TrombinoscopeServerError) {
          return ServerError();
        } else if (state is TrombinoscopePeopleRetrieved) {
          final List<People> people = state.listPeople;
          final String photoUrl = state.photoUrl;
          final String userId = state.id;
          final String userToken = state.token;

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Card(
                      color: Colors.white,
                      child: TextField(
                        onChanged: (value) {
                          _searchPerson(value, context);
                        },
                        controller: searchController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            labelText: I18n.of(context).trombiSearch),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: people.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                                child: InkWell(
                              onTap: () => Navigator.of(context).pushNamed(
                                TrombinoscopeDetails.routeName,
                                arguments: TrombinoscopeDetailArguments(
                                    people[index].name,
                                    Util.capitalize(people[index].surname),
                                    people[index].workPlace,
                                    Util.capitalize(
                                        people[index].structure.name),
                                    people[index].bu,
                                    people[index].email,
                                    people[index].landPhone,
                                    Uri.parse(people[index].photo)
                                        .pathSegments
                                        .last,
                                    photoUrl,
                                    userId,
                                    userToken),
                              ),
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 26.0,
                                        horizontal: 11.0,
                                      ),
                                      child: Container(
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "$photoUrl/${Uri.parse(people[index].photo).pathSegments.last}/$userId/$userToken",
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: 80.0,
                                            height: 80.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              Container(
                                            width: 80.0,
                                            height: 80.0,
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 11.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "${people[index].name} ${Util.capitalize(people[index].surname)}",
                                              style: AppTheme.of(context)
                                                  .trombiUserName,
                                            ),
                                            Text(
                                              "${people[index].workPlace} - ${people[index].structure.name}",
                                              style: AppTheme.of(context)
                                                  .trombiUserWorkplace,
                                            ),
                                            Text(
                                              people[index].bu,
                                              style: AppTheme.of(context)
                                                  .trombiUserBu,
                                            ),
                                            Text(
                                              people[index].email,
                                              style: AppTheme.of(context)
                                                  .trombiUserMail,
                                            ),
                                            Text(
                                              people[index].landPhone,
                                              style: AppTheme.of(context)
                                                  .trombiUserTel,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ));
                          }),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
