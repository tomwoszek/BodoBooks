import 'package:bodobox/ui/widgets/common/custom_button/custom_button.dart';
import 'package:bodobox/ui/widgets/common/custom_device_list_tile/custom_device_list_tile.dart';
import 'package:bodobox/ui/widgets/common/custom_loading_indicator/custom_loading_indicator.dart';
import 'package:bodobox/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:bodobox/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'show_devices_sheet_model.dart';

class ShowDevicesSheet extends StackedView<ShowDevicesSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const ShowDevicesSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ShowDevicesSheetModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);
    return viewModel.isBusy
        ? const Center(child: CustomLoadingIndicator())
        : Container(
            height: MediaQuery.of(context).size.height * 0.5,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  height: 5,
                  width: 60,
                ),
                verticalSpaceMedium,
                Text(
                  'Verknüpfte Geräte',
                  style: theme.textTheme.bodyLarge,
                ),
                if (viewModel.showDeviceOne == true) ...[
                  verticalSpaceMedium,
                  CustomDeviceListTile(
                    description: request.data.deviceOneId,
                    title: request.data.deviceOneName,
                    onPressedCallback: () {
                      viewModel.deleteDevice(
                          request.data.deviceOneId, DeviceIndex.firstDevice);
                    },
                    onDismissedCallback: (direction) async {
                      viewModel.deleteDevice(
                          request.data.deviceOneId, DeviceIndex.firstDevice);
                    },
                  ),
                ],
                if (viewModel.showDeviceTwo == true) ...[
                  verticalSpaceMedium,
                  CustomDeviceListTile(
                    description: request.data.deviceTwoId,
                    title: request.data.deviceTwoName,
                    onPressedCallback: () {
                      viewModel.deleteDevice(
                          request.data.deviceTwoId, DeviceIndex.secondDevice);
                    },
                    onDismissedCallback: (direction) async {
                      viewModel.deleteDevice(
                          request.data.deviceTwoId, DeviceIndex.secondDevice);
                    },
                  ),
                ],
                const Spacer(),
                CustomButton(
                  height: 60,
                  invert: false,
                  label: "Abschließen",
                  onPressedCallback: () {
                    viewModel.closeSheet();
                  },
                ),
                verticalSpaceMedium
              ],
            ),
          );
  }

  @override
  ShowDevicesSheetModel viewModelBuilder(BuildContext context) =>
      ShowDevicesSheetModel(user: request.data);
}
