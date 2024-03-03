import 'package:bodobox/app/app.locator.dart';
import 'package:bodobox/app/app.router.dart';
import 'package:bodobox/services/master_service.dart';
import 'package:bodobox/services/user_servie_service.dart';
import 'package:bodobox/ui/views/register/register_view.form.dart';
import 'package:bodobox/utils/models/book_model.dart';
import 'package:bodobox/utils/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends FormViewModel {
  final NavigationService _navigationService = NavigationService();
  final UserServieService _userServieService = locator<UserServieService>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  void back() {
    _navigationService.back();
  }

  Future<void> login() async {
    setBusy(true);
    final user = BodoboxUser(
      email: emailValue,
      password: passwordValue,
    );
    final serverRequest = await _userServieService.signInUser(user);
    if (serverRequest) {
      _navigationService.clearStackAndShow(Routes.homeView);
      setBusy(false);
    } else {
      setBusy(false);
    }
  }
}
