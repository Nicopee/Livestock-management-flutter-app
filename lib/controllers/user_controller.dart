import 'dart:convert';

import 'package:livestockapp/helpers/helpers.dart';
import 'package:livestockapp/models/access_token.dart';
import 'package:livestockapp/models/user.dart';
import 'package:livestockapp/models/version.dart';
import 'package:livestockapp/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/app_repo.dart';
import '../views/version_update.dart';

class UserController extends ChangeNotifier {
  User user;
  bool isLoggedIn = false;
  AccessToken accessToken;
  NumberFormat currencyFomatter = NumberFormat.currency(
    decimalDigits: 0,
    symbol: "UGX ",
  );
  SharedPreferences sharedPreferences;
  Future<dynamic> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('user') != null) {
      user = User.fromJson(jsonDecode(sharedPreferences.getString('user')));

      accessToken = AccessToken.fromJson(
          jsonDecode(sharedPreferences.getString('token')));

      isLoggedIn = true;
    }
  }

  void resetPassword(String email) async {
    OverlayEntry loader = MethodHelpers.overlayLoader();
    try {
      Overlay.of(Get.overlayContext).insert(loader);
      await UserRepository.resetPassword(email);
      loader.remove();
      Get.offNamed('/success', arguments: {
        'message': 'Password reset link has been sent to $email.'
      });
    } catch (err) {
      loader.remove();
      MethodHelpers.dioErrorHandler(err);
    }
  }

  void saveToken(AccessToken accessToken) {
    this.accessToken = accessToken;
    sharedPreferences.setString('token', jsonEncode(accessToken));
  }

  void login(String email, String password, String goTo) async {
    OverlayEntry loader = MethodHelpers.overlayLoader();
    try {
      Overlay.of(Get.overlayContext).insert(loader);

      Map<String, dynamic> res = await UserRepository.login(email, password);
      isLoggedIn = true;
      user = res['user'];
      accessToken = res['access_token'];
      sharedPreferences.setString('user', jsonEncode(user));
      sharedPreferences.setString('token', jsonEncode(accessToken));
      loader.remove();
      Get.toNamed(
        '/index',
      );
      if (goTo == null) {
        Get.close(1);
      } else {
        Get.offNamed(goTo);
      }
    } catch (err) {
      print(err);
      loader.remove();
      MethodHelpers.dioErrorHandler(err, isAcctBassed: true);
    }

    notifyListeners();
  }

  void updateAccount(Map acct) async {
    OverlayEntry loader = MethodHelpers.overlayLoader();
    try {
      Overlay.of(Get.overlayContext).insert(loader);

      await UserRepository.updateAccount(user.id, acct);

      loader.remove();
      Get.offNamed('/success',
          arguments: {'message': 'Account successfully modified'});
    } catch (err) {
      loader.remove();
      MethodHelpers.dioErrorHandler(err, isAcctBassed: true);
    }
  }

  void checkForUpdates() async {
    try {
      Version version = await AppRepo.checkForUpdate();
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      if (int.parse(packageInfo.buildNumber) < version.minimumSupported) {
        //version is no longer supported
        version.isForced = true;
        await Future.delayed(Duration(seconds: 2));
        Get.to(() => VersionUpdate(),
            fullscreenDialog: true, arguments: {'version': version});
      } else if (version.buildNumber > int.parse(packageInfo.buildNumber)) {
        //version is available
        await Future.delayed(Duration(seconds: 2));
        Get.to(() => VersionUpdate(),
            fullscreenDialog: true, arguments: {'version': version});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void changePassword(String oldPassword, String newPassword) async {
    OverlayEntry loader = MethodHelpers.overlayLoader();
    try {
      Overlay.of(Get.overlayContext).insert(loader);

      await UserRepository.changePassword(oldPassword, newPassword);

      loader.remove();
      Get.offNamed('/success',
          arguments: {'message': 'Password successfully modified'});
    } catch (err) {
      print(err);
      loader.remove();
      MethodHelpers.dioErrorHandler(err, isAcctBassed: true);
    }
  }

  void sendFeedBack(String message) async {
    OverlayEntry loader = MethodHelpers.overlayLoader();
    try {
      Overlay.of(Get.overlayContext).insert(loader);

      await UserRepository.sendFeedBack(message);

      loader.remove();
      Get.offNamed('/success',
          arguments: {'message': 'Your feedback has been received.'});
    } catch (err) {
      loader.remove();
      MethodHelpers.dioErrorHandler(err);
    }
  }

  void signUp(Map user) async {
    OverlayEntry loader = MethodHelpers.overlayLoader();
    try {
      Overlay.of(Get.overlayContext).insert(loader);

      await UserRepository.register(user);

      loader.remove();
      Get.offNamed('/account_created');
    } catch (err) {
      loader.remove();
      MethodHelpers.dioErrorHandler(err, isAcctBassed: true);
    }

    notifyListeners();
  }

  void logOut() async {
    await sharedPreferences.remove('user');
    await sharedPreferences.remove('token');
    user = null;
    accessToken = null;
    isLoggedIn = false;
    notifyListeners();
  }
}
