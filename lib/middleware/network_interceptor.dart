import 'package:livestockapp/constants/constants.dart';
import 'package:livestockapp/controllers/user_controller.dart';
import 'package:livestockapp/models/access_token.dart';
import 'package:livestockapp/models/user.dart';
import 'package:livestockapp/repository/user_repository.dart';
import 'package:dio_http/dio_http.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as get_object;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NetworkInterceptor extends Interceptor {
  Dio networkDio;
  int retry = -1;
  AccessToken accessToken;
  int userId;
  SharedPreferences prefs;
  NetworkInterceptor(this.networkDio, {SharedPreferences sharedPreferences}) {
    if (sharedPreferences == null) {
      accessToken = get_object.Get.context.read<UserController>().accessToken;
    } else {
      accessToken = AccessToken.fromJson(
          jsonDecode(sharedPreferences.getString('token')));
      userId =
          User.fromJson(jsonDecode(sharedPreferences.getString('user'))).id;
      prefs = sharedPreferences;
    }
  }

  @override
  Future onRequest(RequestOptions options, handler) async {
    options.headers['Authorization'] = 'Bearer ' + accessToken.accessToken;
    return handler.next(options);
  }

  @override
  Future onResponse(Response response, handler) async {
    return handler.next(response);
  }

  @override
  Future onError(DioError err, handler) async {
    if (err.response?.statusCode == 401) {
      retry++;

      if (retry == 1) {
        return handler.next(err);
      } else {
        try {
          networkDio.interceptors.requestLock.lock();
          networkDio.interceptors.responseLock.lock();
          RequestOptions requestOptions = err.requestOptions;
          accessToken =
              await UserRepository.requestNewToken(accessToken.refreshToken);
          if (prefs == null) {
            get_object.Get.context
                .read<UserController>()
                .saveToken(accessToken);
          } else {
            prefs.setString('token', jsonEncode(accessToken));
          }

          networkDio.interceptors.requestLock.unlock();
          networkDio.interceptors.responseLock.unlock();
          //remaking the previous request with new token
          var response = await networkDio.fetch(requestOptions);
          return handler.resolve(response);
        } on Exception catch (e) {
          if (prefs == null && !get_object.Get.isDialogOpen) {
            await get_object.Get.dialog(
              AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Session has expired',
                      style: TextStyle(
                          fontSize: title, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: largestButtonWidth,
                      child: RaisedButton(
                        elevation: 0.4,
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        onPressed: () {
                          get_object.Get.context
                              .read<UserController>()
                              .logOut();
                          //We don't go to login page coz the user can still access the app without logging in
                          get_object.Get.close(1);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        textColor: Colors.white,
                        child: Text('Login'),
                      ),
                    )
                  ],
                ),
              ),
              barrierDismissible: false,
            );
          }
          return handler.next(e);
        }
      }
    } else {
      return handler.next(err);
    }
  }
}
