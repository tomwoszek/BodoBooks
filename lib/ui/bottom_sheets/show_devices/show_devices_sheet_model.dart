import 'package:bodobox/app/app.locator.dart';
import 'package:bodobox/services/device_service.dart';
import 'package:bodobox/utils/enums.dart';
import 'package:bodobox/utils/models/user_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ShowDevicesSheetModel extends FutureViewModel {
  ShowDevicesSheetModel({required this.user});
  final BodoboxUser user;
  final DeviceService _deviceService = locator<DeviceService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();

  @override
  Future futureToRun() async {
    if (user.deviceOneId == "zero") {
      _showDeviceOne = false;
    }
    if (user.deviceTwoId == "zero") {
      _showDeviceTwo = false;
    }
  }

  bool _showDeviceOne = true;
  bool _showDeviceTwo = true;

  bool get showDeviceOne => _showDeviceOne;
  bool get showDeviceTwo => _showDeviceTwo;

  Future<void> deleteDevice(
    String deviceId,
    DeviceIndex index,
  ) async {
    final deleted = await _deviceService.deleteDevice(user, deviceId, index);
    switch (index) {
      case DeviceIndex.firstDevice:
        if (deleted) {
          _showDeviceOne = false;
        }
      case DeviceIndex.secondDevice:
        if (deleted) {
          _showDeviceTwo = false;
        }
    }
    rebuildUi();
  }

  void closeSheet() {
    _bottomSheetService.completeSheet(SheetResponse());
  }
}
