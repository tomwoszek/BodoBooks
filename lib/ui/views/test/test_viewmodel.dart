import 'package:bodobox/app/app.locator.dart';
import 'package:bodobox/services/device_service.dart';
import 'package:bodobox/services/house_hold_service.dart';
import 'package:bodobox/services/request_service.dart';
import 'package:bodobox/services/user_servie_service.dart';
import 'package:stacked/stacked.dart';

class TestViewModel extends BaseViewModel {
  final DeviceService userServieService = locator<DeviceService>();
  final HouseHoldService houseHoldService = locator<HouseHoldService>();
  final RequestService requestService = locator<RequestService>();
  final UserServieService userService = locator<UserServieService>();
}
