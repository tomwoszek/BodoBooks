import 'package:bodobox/app/app.bottomsheets.dart';
import 'package:bodobox/app/app.dialogs.dart';
import 'package:bodobox/app/app.locator.dart';
import 'package:bodobox/app/app.router.dart';
import 'package:bodobox/services/house_hold_service.dart';
import 'package:bodobox/services/user_servie_service.dart';
import 'package:bodobox/utils/enums.dart';
import 'package:bodobox/utils/models/user_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsViewModel extends FutureViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final HouseHoldService _houseHoldService = locator<HouseHoldService>();
  final UserServieService _userService = locator<UserServieService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final DialogService _dialogService = locator<DialogService>();
  BodoboxUser? _user;
  BodoboxUser? get user => _user;
  bool _sharingMode = false;
  bool get sharingMode => _sharingMode;

  @override
  Future futureToRun() {
    return getUserData();
  }

  Future<void> getUserData() async {
    _user = await _userService.getUserData();
    _sharingMode = _user!.shareMode!;
  }

  Future<void> changeName() async {
    await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.updateName,
      data: user,
    );
    await getUserData();
    rebuildUi();
  }

  Future<void> showDevices() async {
    _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.showDevices, data: user);
  }

  Future<void> changePassword() async {
    if (user == null) return;
    final status = await _userService.updatePassword(user!);
    if (status) {
      _dialogService.showCustomDialog(
          variant: DialogType.infoAlert,
          description:
              "Es wurde eine E-Mail an die Adresse ${user!.email} gesendet.");
    }
  }

  Future<void> showMasterView() async {
    await _navigationService.navigateToMasterView();
  }

  Future<void> chnageHouseHoldShareMode(value) async {
    await _houseHoldService.changeMode(value, user!);
    _user!.shareMode = value;
    rebuildUi();
  }

  Future<void> showDatenschutz() async {
    await _navigationService.navigateToLegalsView(
        type: LegalTexts.dataSecurity);
  }

  Future<void> showAGB() async {
    await _navigationService.navigateToLegalsView(
        type: LegalTexts.termsOfUsage);
  }

  Future<void> showImpressum() async {
    await _navigationService.navigateToLegalsView(type: LegalTexts.imprint);
  }

  void back() async {
    await _navigationService.clearStackAndShow(Routes.homeView);
  }
}
