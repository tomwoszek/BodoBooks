import 'package:bodobox/app/app.locator.dart';
import 'package:bodobox/app/app.router.dart';
import 'package:bodobox/services/device_service.dart';
import 'package:bodobox/services/user_servie_service.dart';
import 'package:bodobox/ui/views/register/register_view.form.dart';
import 'package:bodobox/utils/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends FormViewModel {
  final NavigationService _navigationService = NavigationService();
  final UserServieService _userServie = locator<UserServieService>();
  final DeviceService _deviceService = locator<DeviceService>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  Future<void> register() async {
    setBusy(true);
    final deviceOne = await _deviceService.getDeviceImei();
    if (deviceOne == null) return;
    final userData = BodoboxUser(
      name: nameValue,
      email: emailValue,
      password: passwordValue,
      masterUser: false,
      deviceOneId: deviceOne.imeiNumber,
      deviceOneName: deviceOne.deviceName,
    );
    final registerState = await _userServie.registerUser(userData);
    if (registerState == true) {
      await _navigationService.clearStackAndShow(Routes.homeView);
      setBusy(false);
    } else {
      setBusy(false);
    }
  }

  void back() {
    _navigationService.back();
  }
}
