import 'package:bodobox/app/app.locator.dart';
import 'package:bodobox/services/user_servie_service.dart';
import 'package:bodobox/utils/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class UpdateNameSheetModel extends FutureViewModel {
  UpdateNameSheetModel({required this.user});
  final BodoboxUser user;
  TextEditingController nameController = TextEditingController();
  final UserServieService _userService = locator<UserServieService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();

  @override
  Future futureToRun() async {
    await setController();
  }

  Future<void> setController() async {
    nameController = TextEditingController(text: user.name);
  }

  Future<void> updateName() async {
    setBusy(true);
    final status = await _userService.updateName(nameController.text, user);
    if (status == true) {
      setBusy(false);
      _bottomSheetService.completeSheet(SheetResponse());
    } else {
      setBusy(false);
    }
  }
}
