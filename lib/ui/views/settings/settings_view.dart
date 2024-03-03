import 'package:bodobox/services/theme_service.dart';
import 'package:bodobox/ui/common/ui_helpers.dart';
import 'package:bodobox/ui/widgets/common/costum_setting_list_tile/costum_setting_list_tile.dart';
import 'package:bodobox/ui/widgets/common/custom_button/custom_button.dart';
import 'package:bodobox/ui/widgets/common/custom_loading_indicator/custom_loading_indicator.dart';
import 'package:bodobox/ui/widgets/common/view_standard/view_standard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'settings_viewmodel.dart';

class SettingsView extends StackedView<SettingsViewModel> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SettingsViewModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: appBarWithLeadingText(
          backgroundColor: theme.colorScheme.onBackground,
          leadingTitle: 'Einstellungen',
          icon: const Icon(Icons.arrow_back_ios),
          leadingWidth: 300,
          onPressedCallback: () {
            viewModel.back();
          }),
      body: viewModel.isBusy
          ? Container(
              color: theme.colorScheme.onBackground,
              child: const Center(
                child: CustomLoadingIndicator(),
              ),
            )
          : ViewStandard(
            backgroundColor: theme.colorScheme.onBackground,
            children: [
              verticalSpaceMedium,
              CostumSettingListTile(
                icon: Icons.change_circle,
                bottom: false,
                top: true,
                label: "Name ändern",
                onTapCallback: () async {
                  await viewModel.changeName();
                },
                leadingWiget: const SizedBox(),
              ),
              const SizedBox(height: 1),
              CostumSettingListTile(
                icon: Icons.devices,
                bottom: false,
                top: false,
                label: "Verknüpfte Geräte",
                onTapCallback: () {
                  viewModel.showDevices();
                },
                leadingWiget: const SizedBox(),
              ),
              const SizedBox(height: 1),
              if (viewModel.user?.masterUser == true) ...[
                CostumSettingListTile(
                  icon: Icons.lock_person,
                  bottom: false,
                  top: false,
                  label: "Master View",
                  onTapCallback: () {
                    viewModel.showMasterView();
                  },
                  leadingWiget: const SizedBox(),
                ),
                const SizedBox(height: 1),
              ],
              CostumSettingListTile(
                icon: Icons.password,
                bottom: true,
                top: false,
                label: "Passwort ändern",
                onTapCallback: () {
                  viewModel.changePassword();
                },
                leadingWiget: const SizedBox(),
              ),
              verticalSpaceMedium,
              CostumSettingListTile(
                icon: Icons.house_outlined,
                bottom: true,
                top: true,
                label: "Bücher im Haus teilen",
                onTapCallback: () {
                  viewModel.chnageHouseHoldShareMode(true);
                },
                leadingWiget: CupertinoSwitch(
                  value: viewModel.user!.shareMode!,
                  onChanged: (value) async {
                    await viewModel.chnageHouseHoldShareMode(value);
                  },
                ),
              ),
              verticalSpaceSmall,
              Text(
                "Wenn du diese Funktion aktivierst, kannst du Bücher mit Freunden und Familie teilen, die sich im gleichen WLAN befinden.",
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              verticalSpaceMedium,
              CostumSettingListTile(
                icon: Icons.description,
                bottom: false,
                top: true,
                label: "Datenschutz",
                onTapCallback: () {
                  viewModel.showDatenschutz();
                },
                leadingWiget: const SizedBox(),
              ),
              const SizedBox(height: 1),
              CostumSettingListTile(
                icon: Icons.description,
                bottom: false,
                top: false,
                label: "AGB's",
                onTapCallback: () {
                  viewModel.showAGB();
                },
                leadingWiget: const SizedBox(),
              ),
              const SizedBox(height: 1),
              CostumSettingListTile(
                icon: Icons.description,
                bottom: true,
                top: false,
                label: "Impressum",
                onTapCallback: () {
                  viewModel.showImpressum();
                },
                leadingWiget: const SizedBox(),
              ),
              verticalSpaceMedium,
              CustomButton(invert: false, label: "Account löschen"),
              CustomButton(invert: false, label: "Ausloggen"),
            ],
          ),
    );
  }

  @override
  SettingsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SettingsViewModel();
}
