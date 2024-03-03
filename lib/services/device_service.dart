import 'package:bodobox/app/app.dialogs.dart';
import 'package:bodobox/app/app.locator.dart';
import 'package:bodobox/services/request_service.dart';
import 'package:bodobox/utils/enums.dart';
import 'package:bodobox/utils/models/device_model.dart';
import 'package:bodobox/utils/models/user_model.dart';
import 'package:device_information/device_information.dart';
import 'package:flutter/services.dart';
import 'package:stacked_services/stacked_services.dart';

class DeviceService {
  static final DialogService _dialogService = locator<DialogService>();
  static final RequestService _requestService = locator<RequestService>();

  Future<Device?> getDeviceImei() async {
    try {
      final imeiNumber = await DeviceInformation.deviceIMEINumber;
      final deivceName = await DeviceInformation.deviceName;
      return Device(deviceName: deivceName, imeiNumber: imeiNumber);
    } on PlatformException {
      _dialogService.showCustomDialog(
          variant: DialogType.error,
          description: "Leider ist ein Fehler aufgetretten.(Fehlercode 101)");
      return null;
    }
  }

  Future<bool> deleteDevice(
      BodoboxUser user, String deviceId, DeviceIndex index) async {
    final status = await _requestService.deleteDevice(user, deviceId, index);
    return status.status;
  }

  Future<bool> isDeviceRegistered(BodoboxUser user) async {
    try {
      final currentDevice = await getDeviceImei();
      if (currentDevice == null) return true;
      if (currentDevice.imeiNumber == user.deviceOneId ||
          currentDevice.imeiNumber == user.deviceTwoId) {
        return true;
      } else {
        await _dialogService.showCustomDialog(
            variant: DialogType.error,
            title: "Du wurdest ausgeloggt.",
            description:
                "Dieses gerät hat keinen Zugriff mehr auf diesen Account");
        await _requestService.logOut();
        return false;
      }
    } catch (e) {
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        description: "$e",
      );
      return true;
    }
  }
}
