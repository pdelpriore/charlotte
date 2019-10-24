import 'dart:convert';
import 'package:flutter_model/core/models/holidays_france.dart';
import 'package:flutter_model/core/models/navigation/exceptions/exceptions.dart';
import 'package:flutter_model/core/models/post.dart';
import 'package:flutter_model/core/models/trombinoscope.dart';
import 'package:flutter_model/core/models/user_holidays.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter_model/core/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  static const BASE_URL = "https://charlotte.groupe-cyllene.com/mobile";
  static const HOLIDAYS_FRANCE =
      "https://jours-feries-france.antoine-augusti.fr/api";
  static const USER_TOKEN = "userToken";
  static const USER_ID = "userId";

  static Future<List<Post>> getAllPosts() async {
    final response = await http.get("$BASE_URL/posts");
    if (response.statusCode != 200) {
      throw ServerError();
    }

    final jsonBody = json.decode(response.body);
    final List<Post> posts = [];
    posts
        .addAll((jsonBody as List).map((post) => Post.fromJson(post)).toList());

    return posts;
  }

  static Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    FormData formData = FormData.from(
        {"id": prefs.get(USER_ID), "token": prefs.get(USER_TOKEN)});

    var user;

    try {
      final response = await Dio().post("$BASE_URL/getUser",
          data: formData,
          options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));

      if (response.statusCode == 500) {
        throw ServerError();
      } else if (response.statusCode == 200) {
        user = User.fromJson(response.data);
      }
    } on DioError catch (error) {
      if (error.message.contains(DioErrors.SOCKET_EXCEPTION))
        throw NetworkError();
    }

    return user;
  }

  static Future<Trombinoscope> getTrombinoscope() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    FormData formData = FormData.from(
        {"id": prefs.get(USER_ID), "token": prefs.get(USER_TOKEN)});

    var trombinoscope;

    try {
      final response = await Dio().post("$BASE_URL/directory",
          data: formData,
          options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));

      if (response.statusCode == 500) {
        throw ServerError();
      } else if (response.statusCode == 200) {
        trombinoscope = Trombinoscope.fromJson(response.data);
      }
    } on DioError catch (error) {
      if (error.message.contains(DioErrors.SOCKET_EXCEPTION))
        throw NetworkError();
    }
    return trombinoscope;
  }

  static Future<UserHolidays> getUserHolidays() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    FormData formData = FormData.from(
        {"id": prefs.get(USER_ID), "token": prefs.get(USER_TOKEN)});

    var userHolidays;

    try {
      final response = await Dio().post("$BASE_URL/conges",
          data: formData,
          options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));

      if (response.statusCode == 500) {
        throw ServerError();
      } else if (response.statusCode == 200) {
        userHolidays = UserHolidays.fromJson(response.data);
      }
    } on DioError catch (error) {
      if (error.message.contains(DioErrors.SOCKET_EXCEPTION))
        throw NetworkError();
    }
    return userHolidays;
  }

  static Future<List<DateTime>> getHolidaysFrance(int year) async {
    final response = await http.get("$HOLIDAYS_FRANCE/$year");
    final List<HolidaysFrance> holidaysFrance =
        (json.decode(response.body) as List)
            .map((holidayFrance) => HolidaysFrance.fromJson(holidayFrance))
            .toList();

    return holidaysFrance
        .map((holidayFrance) => DateTime.parse(holidayFrance.date))
        .toList();
  }

  static Future<bool> deposeHolidays(
      String departureDate, Duration duration, String comments) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    FormData formData = FormData.from({
      "id": prefs.get(USER_ID),
      "token": prefs.get(USER_TOKEN),
      "date": departureDate,
      "valeur": duration.inDays.toString(),
      "comments": comments
    });

    try {
      final response = await Dio().post("$BASE_URL/conges/add",
          data: formData,
          options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));

      if (response.statusCode == 500) {
        throw ServerError();
      }
    } on DioError catch (error) {
      if (error.message.contains(DioErrors.SOCKET_EXCEPTION))
        throw NetworkError();
    }
    return true;
  }

  static Future<bool> hasToken() async {
    await Future.delayed(Duration(seconds: 1));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get(USER_TOKEN);
    return token != null;
  }

  static Future<void> persistToken(String token, String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_TOKEN, token);
    prefs.setString(USER_ID, id);
  }

  static Future<void> clearTokens() async {
    await Future.delayed(Duration(seconds: 1));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(USER_TOKEN);
  }

  static Future<User> login(String userName, String password) async {
    var user;

    FormData formData =
        FormData.from({"login": userName, "password": password});

    try {
      final response = await Dio().post("$BASE_URL/login",
          data: formData,
          options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));

      if (response.statusCode == 401) {
        throw BadCredentialsError();
      } else if (response.statusCode == 500) {
        throw ServerError();
      } else if (response.statusCode == 200) {
        user = User.fromJson(response.data);
      }
    } on DioError catch (error) {
      if (error.message.contains(DioErrors.SOCKET_EXCEPTION)) {
        throw NetworkError();
      }
    }
    return user;
  }
}
