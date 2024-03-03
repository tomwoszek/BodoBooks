// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedBottomsheetGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/bottom_sheets/notice/notice_sheet.dart';
import '../ui/bottom_sheets/show_devices/show_devices_sheet.dart';
import '../ui/bottom_sheets/update_name/update_name_sheet.dart';

enum BottomSheetType {
  notice,
  updateName,
  showDevices,
}

void setupBottomSheetUi() {
  final bottomsheetService = locator<BottomSheetService>();

  final Map<BottomSheetType, SheetBuilder> builders = {
    BottomSheetType.notice: (context, request, completer) =>
        NoticeSheet(request: request, completer: completer),
    BottomSheetType.updateName: (context, request, completer) =>
        UpdateNameSheet(request: request, completer: completer),
    BottomSheetType.showDevices: (context, request, completer) =>
        ShowDevicesSheet(request: request, completer: completer),
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
