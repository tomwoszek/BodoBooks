// ignore_for_file: constant_pattern_never_matches_value_type

import 'package:bodobox/app/app.locator.dart';
import 'package:bodobox/services/prefs_service.dart';
import 'package:bodobox/services/request_service.dart';
import 'package:bodobox/utils/models/user_model.dart';

class UserServieService {
  static final RequestService _requestService = locator<RequestService>();
  static final PrefsService _prefsService = locator<PrefsService>();

  Future<bool> registerUser(BodoboxUser user) async {
    final serverUser = await _requestService.registerUser(user);
    if (serverUser.status == true) {
      await _prefsService.setUserId(serverUser.string);
    }

    return serverUser.status;
  }

  Future<bool> signInUser(BodoboxUser user) async {
    final signedInUser = await _requestService.signInUser(user);
    if (signedInUser.status == true) {
      await _prefsService.setUserId(signedInUser.string);
      return signedInUser.status;
    } else {
      return false;
    }
  }

  Future<BodoboxUser?> getUserData() async {
    final userId = _prefsService.getUserId();
    final user = await _requestService.getUserData(userId!);
    return user;
  }

  Future<bool> updateName(String name, BodoboxUser user) async {
    final status = await _requestService.updateName(user, name);
    return status.status;
  }

  Future<bool> updatePassword(BodoboxUser user) async {
    final status = await _requestService.updatePassword(user);
    return status.status;
  }

  Future<void> logOut() async {
     await _requestService.logOut();
  }

  Future<void> deleteUser() async {
    final userId = _prefsService.getUserId();
    final serverResponse = await _requestService.deleteUser(userId!);
    if(serverResponse.status) {
      await _requestService.logOut();
    }
  } 
}
